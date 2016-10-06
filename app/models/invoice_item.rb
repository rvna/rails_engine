class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def unit_price_in_dollars
    '%.2f' % (self.unit_price / 100.0)
  end
end
