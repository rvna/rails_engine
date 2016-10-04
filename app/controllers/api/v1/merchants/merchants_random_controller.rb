class Api::V1::Merchants::MerchantsRandomController < ApplicationController
  def show
    merchant = Merchant.order("RANDOM()").first
    render json: merchant
  end
end
