class Item < ApplicationRecord
  default_scope { order(id: :asc) }

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def unit_price_in_dollars
    '%.2f' % (self.unit_price / 100.0)
  end
end
