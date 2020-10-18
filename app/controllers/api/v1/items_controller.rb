class Api::V1::ItemsController < ApplicationController

  def create
    render json: Item.create(item_params)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

end
