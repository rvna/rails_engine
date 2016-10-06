class Api::V1::Merchants::TopCustomerController < ApplicationController
  def show
    @top_customer = Merchant.find(params[:merchant_id]).top_customer
  end
end
