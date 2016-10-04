class Api::V1::CustomersController < ApplicationController
  def index
    render json: Customer.all
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: customer, status: 200
    end
  end
end
