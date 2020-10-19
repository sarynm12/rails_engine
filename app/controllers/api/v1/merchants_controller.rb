class Api::V1::MerchantsController < ApplicationController

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  def destroy
    Merchant.destroy(params[:id])
  end

  private

  def merchant_params
    params.permit(:name)
  end

end
