class Api::V1::Invoices::InvoicesFinderController < ApplicationController

  def show
    render json: Invoice.find_by(id: params[:id])
  end
end
