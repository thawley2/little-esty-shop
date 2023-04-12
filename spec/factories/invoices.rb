FactoryBot.define do
  factory :invoice do
    customer
    status { Invoice.statuses.keys.sample }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.now) }
    updated_at { created_at }
  end
end
