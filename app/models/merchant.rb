class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def total_revenue(date)
    revenue = if date.nil?
                total_revenue_for_merchant
              else
                total_revenue_for_merchant_by_day(date)
              end
   '%.2f' % (revenue / 100.0)
  end

  def self.top_selling_items(quantity)
    Merchant.joins(:invoice_items)
            .joins('INNER JOIN transactions
                    ON transactions.invoice_id = invoice_items.invoice_id')
            .where('transactions.result = ?', 'success')
            .select('merchants.*, sum(invoice_items.quantity) AS items_sold')
            .group('merchants.id')
            .order('items_sold desc')
            .limit(quantity)
  end

  def self.most_revenue(quantity)
    Merchant.joins(:invoice_items)
            .joins('INNER JOIN transactions
                    ON transactions.invoice_id = invoice_items.invoice_id')
            .where('transactions.result = ?', 'success')
            .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity)
                    AS total_revenue')
            .group('merchants.id')
            .order('total_revenue desc')
            .limit(quantity)
  end

  def self.total_revenue_by_day(date)
    revenue = Merchant.joins('INNER JOIN invoices
                              ON merchants.id = invoices.merchant_id')
                      .joins('INNER JOIN invoice_items
                              ON invoices.id = invoice_items.invoice_id')
                      .joins('INNER JOIN transactions
                              ON transactions.invoice_id = invoice_items.invoice_id')
                      .where('invoices.created_at = ?', date)
                      .where('transactions.result = ?', 'success')
                      .sum('invoice_items.unit_price * invoice_items.quantity')

    '%.2f' % (revenue / 100.0)
  end

  private

  def total_revenue_for_merchant
    self.invoice_items.joins('INNER JOIN transactions
                              ON transactions.invoice_id = invoice_items.invoice_id')
                       .where('transactions.result = ?', 'success')
                       .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def total_revenue_for_merchant_by_day(date)
    self.invoice_items.joins('INNER JOIN transactions
                              ON transactions.invoice_id = invoice_items.invoice_id')
                       .where('transactions.result = ? AND invoices.created_at = ?', 'success', date)
                       .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
