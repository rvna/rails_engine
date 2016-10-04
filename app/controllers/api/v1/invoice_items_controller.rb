class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItem.all
  end

  def show
    invoice_item = InvoiceItem.find_by(id: params[:id])
    if invoice_item.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: invoice_item, status: 200
    end
  end
end
