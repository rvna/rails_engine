class Api::V1::Merchants::RandomController < ApplicationController
  def show
    @merchant = Merchant.order("RANDOM()").first
  end
end
