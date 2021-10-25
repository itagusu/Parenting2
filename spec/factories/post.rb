FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(number: 200) }
  end
end
