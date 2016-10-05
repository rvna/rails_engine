class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    @transactions = Invoice.transactions
  end
end
