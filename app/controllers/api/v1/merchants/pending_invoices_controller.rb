class Api::V1::Merchants::PendingInvoicesController < ApplicationController
  def index
    @pending_invoices = Merchant.find_by(id: params[:merchant_id]).pending_invoices
  end
end
