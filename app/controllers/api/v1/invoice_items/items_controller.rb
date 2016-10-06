class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def show
    @item = InvoiceItem.find_by(id: params[:invoice_item_id]).item
  end
end
