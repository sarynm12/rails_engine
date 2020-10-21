require 'rails_helper'

RSpec.describe 'Item finders' do
  it 'can return a single item that matches the name parameters passed into a query' do
    merchant = create(:merchant)
    item1 = create(:item, name: "Owl Stuffy", description: "Harry Potter Owl Stuffed Animal", unit_price: 8.00, merchant: merchant)
    item2 = create(:item, name: "Beanie Baby", description: "Vintage Beanie Baby Doll", unit_price: 200.00, merchant: merchant)

    get "/api/v1/items/find?name=owl"

    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name]).to eq(item1.name)
    expect(item[:data][:attributes][:name]).to_not eq(item2.name)

    #add in test and update method for partial matches
  end

  # it 'can return a single merchant that matches the created_at parameter passed into a query' do
  #   merchant1 = create(:merchant)
  #   merchant2 = create(:merchant)
  #
  #   get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"
  #
  #   expect(response).to be_successful
  #   merchant = JSON.parse(response.body, symbolize_names: true)
  #
  #   expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
  #   expect(merchant[:data][:attributes][:name]).to_not eq(merchant2.name)
  # end
  #
  # it 'can return all records that match a set of query paramaters' do
  #   merchant1 = create(:merchant, name: "Severus Snape")
  #   merchant2 = create(:merchant, name: "Sev Slytherin")
  #   merchant3 = create(:merchant, name: "Sly Dog")
  #   merchant4 = create(:merchant, name: "Dog Man")
  #
  #   get "/api/v1/merchants/find_all?name=sly"
  #
  #   expect(response).to be_successful
  #   merchants = JSON.parse(response.body, symbolize_names: true)
  #   expect(merchants[:data].count).to eq(2)
  #   merchants[:data].each do |merchant|
  #     expect(merchants[:data][0][:attributes][:name]).to eq(merchant2.name)
  #     expect(merchants[:data][1][:attributes][:name]).to eq(merchant3.name)
  #   end
  # end

end
