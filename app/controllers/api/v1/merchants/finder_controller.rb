class Api::V1::Merchants::FinderController < ApplicationController
  def index
    merchants = Merchant.where(merchant_params)
    if merchants.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: merchants, status: 200
    end
  end

  def show
    merchant = Merchant.find_by(merchant_params)
    if merchant.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: merchant, status: 200
    end
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
