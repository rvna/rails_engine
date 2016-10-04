class Api::V1::Transactions::RandomController < ApplicationController
  def show
    transaction = Transaction.order("RANDOM()").first
    render json: transaction
  end
end
