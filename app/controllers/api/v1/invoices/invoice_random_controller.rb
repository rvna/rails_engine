class Api::V1::Invoices::InvoiceRandomController < ApplicationController

  def show
    render json: Invoice.order("RANDOM()").first
  end
end
