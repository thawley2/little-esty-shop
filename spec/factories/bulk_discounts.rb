FactoryBot.define do
  factory :bulk_discount do
    merchant
    name {Faker::Hobby.activity}
    percent_discount { Faker::Number.between from: 0.01, to: 0.50}
    quantity_threshold { Faker::Number.between(from: 1, to: 10) }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.now) }
    updated_at { created_at }
  end
end