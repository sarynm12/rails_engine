class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

end
