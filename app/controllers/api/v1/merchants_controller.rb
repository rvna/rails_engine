class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    merchant = Merchant.find_by(id: params[:id])
    if merchant.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: merchant, status: 200
    end
  end
end
