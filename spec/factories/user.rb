FactoryBot.define do
  factory :user do
    sequence(:last_name) { |n| "TEST_LAST_NAME#{n}"}
    sequence(:first_name) { |n| "TEST_FIRST_NAME#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    introduction { Faker::Lorem.characters(number:100) }
  end
end