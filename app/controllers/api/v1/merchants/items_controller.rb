class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    @items = Merchant.find_by(id: params[:merchant_id]).items
  end
end
