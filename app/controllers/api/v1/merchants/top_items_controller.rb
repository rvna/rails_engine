class Api::V1::Merchants::TopItemsController < ApplicationController
  def index
    @merchants = Merchant.top_selling_items(params[:quantity])
  end
end
