class Api::V1::InvoiceItems::InvoiceItemRandomController <ApplicationController
  def show
    render json: InvoiceItem.order("RANDOM()").first
  end
end
