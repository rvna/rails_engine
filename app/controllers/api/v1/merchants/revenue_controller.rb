class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    @merchant = Merchant.find_by(id: params[:id])
  end
end
