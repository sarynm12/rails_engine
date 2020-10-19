require 'rails_helper'

RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  # it 'can get an item by its id' do
  #   create(:merchant)
  #   merchant = Merchant.first
  #   id = create(:item, merchant: merchant).id
  #
  #   get "/api/v1/items/#{id}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body, symbolize_names: true)
  #
  #   expect(item[:data]).to have_key(:id)
  #   expect(item[:data][:id]).to be_a(String)
  #   expect(item[:data][:attributes]).to have_key(:name)
  #   expect(item[:data][:attributes][:name]).to be_a(String)
  #   expect(item[:data][:attributes]).to have_key(:description)
  #   expect(item[:data][:attributes][:description]).to be_a(String)
  #   expect(item[:data][:attributes]).to have_key(:unit_price)
  #   expect(item[:data][:attributes][:unit_price]).to be_a(Float)
  # end
  #
  # it 'can create a new item' do
  #   merchant_id = create(:merchant).id
  #
  #   item_params = { name: 'Harry Potter doll', description: 'Your very own Harry Potter', unit_price: 12.00, merchant_id: merchant_id }
  #
  #   post "/api/v1/items", params: item_params
  #   expect(response).to be_successful
  #
  #   json = JSON.parse(response.body, symbolize_names: true)
  #   item = Item.last
  #
  #   expect(item.name).to eq(item_params[:name])
  #   expect(item.description).to eq(item_params[:description])
  #   expect(item.unit_price).to eq(item_params[:unit_price])
  #   expect(item.merchant_id).to eq(item_params[:merchant_id])
  # end
  #
  # it 'can update an existing item' do
  #   merchant = create(:merchant)
  #   id = create(:item, merchant: merchant).id
  #   previous = Item.last.name
  #   item_params = { name: 'Hermione Granger Doll' }
  #
  #   patch "/api/v1/items/#{id}", params: item_params
  #   item = Item.find(id)
  #   json = JSON.parse(response.body, symbolize_names: true)
  #
  #   expect(response).to be_successful
  #   expect(item.name).to_not eq(previous)
  #   expect(item.name).to eq('Hermione Granger Doll')
  # end
  #
  # it 'can delete an item' do
  #   create(:merchant)
  #   merchant = Merchant.first
  #   item = create(:item, merchant: merchant)
  #
  #   expect(Item.count).to eq(1)
  #
  #   delete "/api/v1/items/#{item.id}"
  #
  #   expect(response).to be_successful
  #   expect(Item.count).to eq(0)
  #   expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  # end
end
