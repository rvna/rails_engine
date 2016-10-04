class Api::V1::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find_by(id: params[:id])
  end
end
