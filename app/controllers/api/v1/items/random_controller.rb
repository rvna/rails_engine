class Api::V1::Items::RandomController < ApplicationController
  def show
    @item = Item.order("RANDOM()").first
  end

end
