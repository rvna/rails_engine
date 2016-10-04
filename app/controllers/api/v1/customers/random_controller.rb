class Api::V1::Customers::RandomController < ApplicationController
  def show
    customer = Customer.order('RANDOM()').first
    render json: customer
  end
end
