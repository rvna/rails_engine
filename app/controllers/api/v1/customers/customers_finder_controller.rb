class Api::V1::Customers::CustomersFinderController < ApplicationController
  def index
    customers = find_customers
    if customers.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: customers, status: 200
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

  def find_customers
    if customer_params.values[0].is_a?(String)
      Customer.where("#{customer_params.keys[0]} like ?", "%#{customer_params.values[0]}%")
    else
      Customer.where(customer_params)
    end
  end

  def customer_params
    params.permit(:first_name, :last_name)
  end
end
