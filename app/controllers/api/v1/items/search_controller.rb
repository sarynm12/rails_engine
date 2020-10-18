class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  # def create
  #   render json: Item.create(item_params)
  # end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

end
