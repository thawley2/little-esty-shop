FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.now) }
    updated_at { created_at }
  end
end