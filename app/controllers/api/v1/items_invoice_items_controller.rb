class Api::V1::ItemsInvoiceItemsController < ApplicationController
  def index
    @invoice_items = Item.find_by(id: params[:item_id]).invoice_items
  end
end
