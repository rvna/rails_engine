class Api::V1::Customers::FinderController < ApplicationController
  def index
    @customers = Customer.where(customer_params)
    if customers.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: customers, status: 200
    end
  end

  def show
    @customer = Customer.find_by(customer_params)
  end

  private

  def customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
