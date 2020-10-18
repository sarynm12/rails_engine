class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.all
  end

  def show
  end

end
