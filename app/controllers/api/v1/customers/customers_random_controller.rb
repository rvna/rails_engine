class Api::V1::Customers::CustomersRandomController < ApplicationController
  def show
    customer = Customer.order('RANDOM()').first
    render json: customer
  end
end
