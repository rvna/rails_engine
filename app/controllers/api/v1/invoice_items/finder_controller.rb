class Api::V1::InvoiceItems::FinderController < ApplicationController
  def show
    @invoice_item = InvoiceItem.find_by(invoice_item_params)
  end

  def index
    @invoice_items = InvoiceItem.where(invoice_item_params)
  end

  private

  def invoice_item_params
    if params.keys.include?('unit_price')
      {unit_price: (params['unit_price'].to_f * 100)}
    else
      params.permit(:id, :quantity, :created_at, :updated_at, :item_id, :invoice_id)
    end
  end

end
