class Api::V1::Customers::FinderController < ApplicationController
  def index
    @customers = Customer.where(customer_params)
  end

  def show
    @customer = Customer.find_by(customer_params)
  end

  private

  def customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
