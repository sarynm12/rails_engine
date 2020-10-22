require 'rails_helper'

RSpec.describe 'Merchant items' do
  it 'can return merchants with the most items sold' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    item1 = create(:item, unit_price: 10.00, merchant: merchant1)
    item2 = create(:item, unit_price: 10.00, merchant: merchant2)
    item3 = create(:item, unit_price: 10.00, merchant: merchant3)
    item4 = create(:item, unit_price: 10.00, merchant: merchant4)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant3)
    invoice4 = create(:invoice, merchant: merchant4)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 30, unit_price: item1.unit_price)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 20, unit_price: item2.unit_price)
    invoice_item3 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 5, unit_price: item3.unit_price)
    invoice_item4 = create(:invoice_item, item: item4, invoice: invoice4, quantity: 10, unit_price: item4.unit_price)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice3)
    transaction4 = create(:transaction, invoice: invoice4)

    get "/api/v1/merchants/most_items?quantity=2"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(2)
    expect(merchants[:data][0][:attributes][:name]).to eq(merchant1.name)
    expect(merchants[:data][1][:attributes][:name]).to eq(merchant2.name)
  end

  it 'will not include a merchant with top items if their transactions are unsuccessful' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    item1 = create(:item, unit_price: 10.00, merchant: merchant1)
    item2 = create(:item, unit_price: 10.00, merchant: merchant2)
    item3 = create(:item, unit_price: 10.00, merchant: merchant3)
    item4 = create(:item, unit_price: 10.00, merchant: merchant4)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant3)
    invoice4 = create(:invoice, merchant: merchant4)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 30, unit_price: item1.unit_price)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 20, unit_price: item2.unit_price)
    invoice_item3 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 5, unit_price: item3.unit_price)
    invoice_item4 = create(:invoice_item, item: item4, invoice: invoice4, quantity: 10, unit_price: item4.unit_price)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2, result: 'unsuccessful')
    transaction3 = create(:transaction, invoice: invoice3)
    transaction4 = create(:transaction, invoice: invoice4)

    get "/api/v1/merchants/most_items?quantity=2"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(2)
    expect(merchants[:data][0][:attributes][:name]).to eq(merchant1.name)
    expect(merchants[:data][1][:attributes][:name]).to eq(merchant4.name)
  end

end
