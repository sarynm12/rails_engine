require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do
    it 'can return the merchants with the most revenue' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      item1 = create(:item, unit_price: 10.00, merchant: merchant1)
      item2 = create(:item, unit_price: 10.00, merchant: merchant2)
      item3 = create(:item, unit_price: 10.00, merchant: merchant3)
      item4 = create(:item, unit_price: 10.00, merchant: merchant4)
      invoice1 = create(:invoice, merchant: merchant1, status: 'pending')
      invoice2 = create(:invoice, merchant: merchant2)
      invoice3 = create(:invoice, merchant: merchant3)
      invoice4 = create(:invoice, merchant: merchant4)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 10, unit_price: item1.unit_price)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 20, unit_price: item2.unit_price)
      invoice_item3 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 5, unit_price: item3.unit_price)
      invoice_item4 = create(:invoice_item, item: item4, invoice: invoice4, quantity: 10, unit_price: item4.unit_price)
      transaction1 = create(:transaction, invoice: invoice1)
      transaction2 = create(:transaction, invoice: invoice2)
      transaction3 = create(:transaction, invoice: invoice3)
      transaction4 = create(:transaction, invoice: invoice4)

      expect(Merchant.most_revenue(3)).to eq([merchant2, merchant4, merchant3])
    end

    it 'can return the merchants with the most items sold, by descending order' do
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

      expect(Merchant.most_items(4)).to eq([merchant1, merchant2, merchant4, merchant3])
    end
  end
end
