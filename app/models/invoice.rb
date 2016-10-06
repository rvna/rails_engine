class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer

  scope :pending, -> {
    select(:id)
    .joins('INNER JOIN transactions AS t1
            ON invoices.id = t1.invoice_id')
    .joins('LEFT OUTER JOIN transactions AS t2
            ON invoices.id = t2.invoice_id
            AND t2.result = ?', 'success')
    .where('t2.invoice_id IS NULL')
  }
end
