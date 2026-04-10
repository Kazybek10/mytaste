FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    publish_year { Faker::Number.between(from: 1900, to: 2024) }
    description { Faker::Lorem.paragraph }
    association :user
  end
end
