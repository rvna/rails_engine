class Api::V1::Invoices::FinderController < ApplicationController

  def show
    invoice = Invoice.find_by(invoice_params)
    if invoice.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: invoice, status: 200
    end
  end

  def index
    invoice = Invoice.where(invoice_params)
    if invoice.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: invoice, status: 200
    end
  end

  private

  def invoice_params
    params.permit(:id, :status, :created_at, :updated_at, :customer_id, :merchant_id)
  end
end
