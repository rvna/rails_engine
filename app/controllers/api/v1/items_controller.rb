class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  def show
    item = Item.find_by(id: params[:id])
    if item.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: item, status: 200
    end
  end
end
