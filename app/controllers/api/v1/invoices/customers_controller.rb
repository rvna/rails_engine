class Api::V1::Invoices::CustomersController < ApplicationController
  def show
    @customer = Invoice.find_by(id: params[:id]).customer
  end
end
