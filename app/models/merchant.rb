class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def total_revenue
    revenue = self.invoice_items.joins('INNER JOIN transactions 
                                        ON transactions.invoice_id = invoice_items.invoice_id')
                                .where('transactions.result = ?', 'success')
                                .sum('invoice_items.unit_price * invoice_items.quantity')
                                        
   '%.2f' % (revenue / 100.0)
  end

end
