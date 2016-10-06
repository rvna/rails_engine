class Api::V1::Transactions::RandomController < ApplicationController
  def show
    @transaction = Transaction.order("RANDOM()").first
  end
end
