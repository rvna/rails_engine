class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    @invoices = Merchant.find(params[:merchant_id]).invoices
  end
end
