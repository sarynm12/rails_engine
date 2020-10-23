class Api::V1::Items::FindController < ApplicationController

  def show
    attribute = params.keys.first
    value = params[attribute]
      if item_params.keys.first == "name"
        item = Item.where("name ILIKE ?", "%#{item_params[:name]}%").first
      elsif attribute == "description"
        item = Item.where("description ILIKE ?", "%#{item_params[:description]}%").first
      elsif attribute == "unit_price"
        item = Item.where(unit_price: "#{value}.to_f").first
      else attribute == "created_at" || "updated_at"
        item = Item.where("item.#{attribute}.to_date" == "#{value.to_date}").first
      end
    render json: ItemSerializer.new(item)
  end

  def index
    attribute = params.keys.first
    value = params[attribute]
      if item_params.keys.first == "name"
        items = Item.where("name ILIKE ?", "%#{item_params[:name]}%")
      elsif attribute == "description"
        items = Item.where("description ILIKE ?", "%#{item_params[:description]}%")
      elsif attribute == "unit_price"
        items = Item.where(unit_price: "#{value}.to_f")
      else attribute == "created_at" || "updated_at"
        items = Item.where("item.#{attribute}.to_date" == "#{value.to_date}")
      end
    render json: ItemSerializer.new(items)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

end
