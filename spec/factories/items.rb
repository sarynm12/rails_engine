FactoryBot.define do
  factory :item do
    name { Faker::Music.instrument }
    description { Faker::Music.band ("Original") }
    unit_price { Faker::Commerce.price }
    merchant 
  end
end
