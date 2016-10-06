class Api::V1::InvoiceItemsController < ApplicationController
  def index
    @invoice_items = InvoiceItem.all
  end

  def show
    @invoice_item = InvoiceItem.find_by(id: params[:id])
  end
end
