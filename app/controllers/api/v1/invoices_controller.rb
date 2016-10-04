class Api::V1::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
  end

  def show
    invoice = Invoice.find_by(id: params[:id])
    if invoice.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: invoice, status: 200
    end
  end
end
