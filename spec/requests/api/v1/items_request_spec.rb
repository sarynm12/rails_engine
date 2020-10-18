require 'rails_helper'

RSpec.describe "Items API" do
  it "sends a list of items" do
    create(:merchant)
    merchant = Merchant.first
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
    end
  end

  it 'can get an item by its id' do
    create(:merchant)
    merchant = Merchant.first
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(Integer)
    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)
    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)
    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)
  end

  it 'can create a new item' do
    merchant_id = create(:merchant).id

    item_params = { name: 'Harry Potter doll', description: 'Your very own Harry Potter', unit_price: 12.00, merchant_id: merchant_id }

    post "/api/v1/items", params: item_params
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    item = Item.last

    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  end
end
