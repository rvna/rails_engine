class Api::V1::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find_by(id: params[:id])
  end
end
