class Api::V1::Merchants::FinderController < ApplicationController
  def index
    @merchants = Merchant.where(merchant_params)
  end

  def show
    @merchant = Merchant.find_by(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
