class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    @merchant = Invoice.find_by(id: params[:id]).merchant
  end
end
