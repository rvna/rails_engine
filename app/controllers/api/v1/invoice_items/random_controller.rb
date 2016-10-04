class Api::V1::InvoiceItems::RandomController <ApplicationController
  def show
    @invoice_item = InvoiceItem.order("RANDOM()").first
  end
end
