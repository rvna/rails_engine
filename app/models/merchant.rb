class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def total_revenue
    revenue = self.invoices.collect do |invoice|
      invoice.transactions.where(result: 'success')
    end.collect do |relation|
      relation.map{|transaction| InvoiceItem.where(invoice_id: transaction.invoice_id).sum('unit_price * quantity')}
    end.flatten.sum
    '%.2f' % (revenue / 100.0)
  end
end
