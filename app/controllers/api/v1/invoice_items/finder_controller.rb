class Api::V1::InvoiceItems::FinderController < ApplicationController
  def show
    invoice_item = InvoiceItem.find_by(invoice_item_params)
    if invoice_item.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: invoice_item, status: 200
    end
  end

  def index
    invoice_item = InvoiceItem.where(invoice_item_params)
    if invoice_item.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: invoice_item, status: 200
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :quantity, :unit_price, :created_at, :updated_at, :item_id, :invoice_id)
  end

end
