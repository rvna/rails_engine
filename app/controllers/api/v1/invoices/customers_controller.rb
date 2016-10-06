class Api::V1::Invoices::CustomersController < ApplicationController
  def show
    @customer = Invoice.find_by(id: params[:invoice_id]).customer
  end
end
