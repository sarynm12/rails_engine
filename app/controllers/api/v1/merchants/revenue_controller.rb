class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  # def show
  #   merchant = Merchant.revenue(params[:id])
  #   render json: MerchantSerializer.new(merchant)
  # end

end
