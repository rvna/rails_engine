class Api::V1::Customers::CustomersFinderController < ApplicationController
  def index
    customer = Customer.where(customer_params)
    if customer.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: customer, status: 200
    end
  end

  def show
    customer = Customer.find_by(customer_params)
    if customer.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: customer, status: 200
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name)
  end
end
