class Api::V1::Items::FinderController < ApplicationController
  def show
    item = Item.find_by(item_params)
    if item.nil?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: item, status: 200
    end
  end

  def index
    item = Item.where(item_params)
    if item.empty?
      render json: {error: 'not-found'}.to_json, status: 404
    else
      render json: item, status: 200
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :created_at, :updated_at, :merchant_id)
  end
end
