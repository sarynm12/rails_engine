class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    render json: RevenueSerializer.new(Merchant.revenue_across_dates(params[:start_date], params[:end_date]))
  end

end
