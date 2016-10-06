class Api::V1::Invoices::FinderController < ApplicationController

  def show
    @invoice = Invoice.find_by(invoice_params)
  end

  def index
    @invoices = Invoice.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:id, :status, :created_at, :updated_at, :customer_id, :merchant_id)
  end
end
