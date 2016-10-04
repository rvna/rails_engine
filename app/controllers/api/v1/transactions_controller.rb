class Api::V1::TransactionsController < ApplicationController
  def index
    render json: Transaction.all
  end

  def show
    transaction = Transaction.find_by(id: params[:id])
    if transaction.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: transaction, status: 200
    end
  end
end
