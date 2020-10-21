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

  def index
    attribute = params.keys.first
    value = params[attribute]
      if merchant_params.keys.first == "name"
        merchants = Merchant.where("name ILIKE ?", "%#{merchant_params[:name]}%")
      else attribute == "created_at" || "updated_at"
        merchants = Merchant.where("merchant.#{attribute}.to_date" == "#{value.to_date}")
      end
    render json: MerchantSerializer.new(merchants)
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end

end
