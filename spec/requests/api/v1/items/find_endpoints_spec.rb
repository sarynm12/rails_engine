require 'rails_helper'

RSpec.describe 'Item finders' do
  before(:each) do
    @merchant = create(:merchant)
    @item1 = create(:item, name: "Owl Stuffy", description: "Harry Potter Owl Stuffed Animal", unit_price: 8.00, merchant: @merchant)
    @item2 = create(:item, name: "Beanie Baby", description: "Vintage Beanie Baby Doll", unit_price: 200.00, merchant: @merchant, created_at: '02-02-2020')
  end

  it 'can return a single item that matches the name parameters passed into a query' do

    get "/api/v1/items/find?name=owl"

    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name]).to eq(@item1.name)
    expect(item[:data][:attributes][:name]).to_not eq(@item2.name)
  end

  it 'can return a single item that matches the description parameter passed into a query' do

    get "/api/v1/items/find?description=beanie baby"

    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:description]).to eq(@item2.description)
    expect(item[:data][:attributes][:description]).to_not eq(@item1.description)
  end

  it 'can return a single item that matches the unit price paramter passed into a query' do

    get "/api/v1/items/find?unit_price=8.00"

    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:unit_price]).to eq(@item1.unit_price)
    expect(item[:data][:attributes][:unit_price]).to_not eq(@item2.unit_price)
  end

  it 'can return a single item that matches the created_at parameter passed into a query' do

    get "/api/v1/items/find?created_at=02/02/2020"

    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)

    #expect(item[:data][:attributes][:name]).to eq(@item2.name)
  end

  it 'can return multiple items that match the name parameter passed into a query' do
    item3 = create(:item, name: "Stuff", merchant: @merchant)

    get "/api/v1/items/find_all?name=StUff"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
  end

  it 'can return multiple items that match the description parameter passed into a query' do
    item3 = create(:item, name: "Stuff", merchant: @merchant, description: "CAT")

    get "/api/v1/items/find_all?description=a"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)
  end

  it 'can return multiple items that match the unit_price parameter passed into a query' do
    item3 = create(:item, name: "Stuff", merchant: @merchant, description: "cat", unit_price: 8.00)

    get "/api/v1/items/find_all?unit_price=8.00"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)

    get "/api/v1/items/find_all?unit_price=200.00"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(1)
  end

end
