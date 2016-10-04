class Api::V1::Transactions::TransactionsRandomController < ApplicationController
  def show
    transaction = Transaction.order("RANDOM()").first
    render json: transaction
  end
end
