FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..20) }
    unit_price { Faker::Commerce.price }
    item
    invoice 
  end
end
