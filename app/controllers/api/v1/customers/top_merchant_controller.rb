class Api::V1::Customers::TopMerchantController < ApplicationController
  def show
    @top_merchant = Customer.find_by(id: params[:customer_id]).top_merchant
  end
end
