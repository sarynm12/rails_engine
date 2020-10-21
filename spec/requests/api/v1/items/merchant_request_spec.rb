require 'rails_helper'

RSpec.describe "Item/Merchant relationship" do
  it "can find an items merchant" do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    
    expect(parsed.count).to eq(1)
    expect(parsed[:data]).to have_key(:id)
    expect(parsed[:data][:id]).to be_a(String)
    expect(parsed[:data][:attributes]).to have_key(:name)
    expect(parsed[:data][:attributes][:name]).to be_a(String)
  end
end
