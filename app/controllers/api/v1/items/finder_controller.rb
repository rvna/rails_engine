class Api::V1::Items::FinderController < ApplicationController
  def show
    @item = Item.find_by(item_params)
  end

  def index
    @items = Item.where(item_params)
  end

  private

  def item_params
    if params.keys.include?('unit_price')
      {unit_price: (params['unit_price'].to_f * 100).round}
    else
      params.permit(:id, :name, :description, :created_at, :updated_at, :merchant_id)
    end
  end
end
