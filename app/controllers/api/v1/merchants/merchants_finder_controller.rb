class Api::V1::Merchants::MerchantsFinderController < ApplicationController
  def index
    merchants = Merchant.where('lower(name) like ?', "%#{params[:name].downcase}%")
    if merchants.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: merchants, status: 200
    end
  end

  def show
    merchant = Merchant.find_by('lower(name) = ?', params[:name].downcase)
    if merchant.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: merchant, status: 200
    end
  end
end
