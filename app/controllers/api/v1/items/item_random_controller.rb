class Api::V1::Items::ItemRandomController < ApplicationController
  def show
    render json: Item.order("RANDOM()").first
  end

end
