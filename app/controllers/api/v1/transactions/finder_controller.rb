class Api::V1::Transactions::FinderController < ApplicationController
  def index
    transactions = Transaction.where(transaction_params)
    if transactions.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: transactions, status: 200
    end
  end

  def show
    transaction = Transaction.find_by(transaction_params)
    if transaction.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: transaction, status: 200
    end
  end

  private

  def transaction_params
    params.permit(:id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at, :invoice_id)
  end
end
