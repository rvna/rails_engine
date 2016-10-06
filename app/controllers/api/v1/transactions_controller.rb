class Api::V1::TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find_by(id: params[:id])
  end
end
