require 'rails_helper'

RSpec.describe "Item/Merchant relationship" do
  it "can find a merchants items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)
    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)
    items[:data].each do |item|
      expect(item[:attributes][:merchant_id]).to eq(merchant.id)
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it 'can return the correct items' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    items = create_list(:item, 2, merchant: merchant1)
    item3 = create(:item, merchant: merchant2)

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
    items[:data].each do |item|
      expect(item[:attributes][:merchant_id]).to_not eq(merchant2.id)
      expect(item[:attributes][:merchant_id]).to eq(merchant1.id)
    end

    get "/api/v1/merchants/#{merchant2.id}/items"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
  
    expect(item[:data].count).to eq(1)
  end
end
