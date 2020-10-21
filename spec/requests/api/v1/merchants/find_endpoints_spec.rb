require 'rails_helper'

RSpec.describe 'Merchant single finders' do
  it 'can return a single merchant that matches the name parameters passed into a query' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant1.name}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant2.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant3.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant4.name)

    #add in test and update method for partial matches
  end

  it 'can return a single merchant that matches the created_at parameter passed into a query' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant2.name)
  end

end
