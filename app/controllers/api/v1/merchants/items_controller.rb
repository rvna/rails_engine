class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    @merchants = Merchant.top_selling_items(params[:quantity])
  end
end
