class Api::V1::Items::FindController < ApplicationController

  def show
    attribute = params.keys.first
    value = params[attribute]
      if item_params.keys.first == "name"
        item = Item.where("name ILIKE ?", "%#{item_params[:name]}%").first
      elsif attribute == "description"
          item = Item.where("description ILIKE ?", "%#{item_params[:description]}%").first
      elsif attribute == "unit_price"
          item = Item.where("item.#{attribute}" == "#{value}").first
      else attribute == "created_at" || "updated_at"
        merchant = Item.where("item.#{attribute}.to_date" == "#{value.to_date}").first
      end
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

end
