class Api::V1::Items::MostItemsController < ApplicationController
  def index
    @most_items = Item.most_items(params[:quantity])
  end
end
