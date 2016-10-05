class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    @merchant = Merchant.find_by(id: params[:id])
  end

  def index
    @merchants = Merchant.most_revenue(params[:quantity])
  end
end
