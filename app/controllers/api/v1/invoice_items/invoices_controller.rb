class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def show
    @invoice = InvoiceItem.find_by(id: params[:id]).invoice
  end
end
