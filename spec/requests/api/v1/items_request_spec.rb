require 'rails_helper'

RSpec.describe "Items API" do
  it "sends a list of items" do
    create(:merchant)
    merchant = Merchant.first
    create_list(:item, 3, merchant: merchant)
    item = Item.last
    get '/api/v1/items'

    expect(response).to be_successful
  end
end
