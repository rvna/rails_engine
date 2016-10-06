class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def top_merchant
    self.merchants.select('merchants.*, count(transactions.id) AS merchant_count')
                  .joins('INNER JOIN transactions
                          ON invoices.id = transactions.invoice_id')
                  .where('transactions.result = ?', 'success')
                  .group('merchants.id')
                  .order('merchant_count DESC')
                  .limit(1)
                  .first
  end
end
