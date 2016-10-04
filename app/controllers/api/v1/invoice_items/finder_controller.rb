class Api::V1::InvoiceItems::FinderController < ApplicationController
  def show
    @invoice_item = InvoiceItem.find_by(invoice_item_params)
  end

  def index
    @invoice_items = InvoiceItem.where(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :quantity, :unit_price, :created_at, :updated_at, :item_id, :invoice_id)
  end

end
