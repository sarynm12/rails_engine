class Api::V1::Merchants::FindController < ApplicationController

  def show
    attribute = params.keys.first
    value = params[attribute]
      if merchant_params.keys.first == "name"
        merchant = Merchant.where("name ILIKE ?", "%#{merchant_params[:name]}%").first
      else attribute == "created_at" || "updated_at"
        merchant = Merchant.where("merchant.#{attribute}.to_date" == "#{value.to_date}").first
      end
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end

end
