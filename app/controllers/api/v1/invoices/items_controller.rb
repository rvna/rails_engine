class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    @items = Invoice.find_by(id: params[:id]).items
  end
end
