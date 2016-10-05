class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    @transactions = Invoice.find_by(id: params[:id]).transactions
  end
end
