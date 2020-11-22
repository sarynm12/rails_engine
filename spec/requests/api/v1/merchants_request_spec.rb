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

  it 'can get a merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'can create a new merchant' do
    merchant_id = create(:merchant).id

    merchant_params = { name: 'Ron Weasley' }

    post "/api/v1/merchants", params: merchant_params
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = Merchant.last

    expect(merchant.name).to eq(merchant_params[:name])
    expect(Merchant.count).to eq(2)
  end

  it 'can update an existing merchant' do
    id = create(:merchant).id

    previous = Merchant.last.name
    merchant_params = { name: 'Saryn Mooney' }

    patch "/api/v1/merchants/#{id}", params: merchant_params
    merchant = Merchant.find(id)
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous)
    expect(merchant.name).to eq('Saryn Mooney')
  end

  it 'can delete a merchant' do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
