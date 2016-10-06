class Api::V1::Invoices::RandomController < ApplicationController
  def show
    @invoice = Invoice.order("RANDOM()").first
  end
end
