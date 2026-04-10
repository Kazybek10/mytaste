FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    director { Faker::Name.name }
    release_year { Faker::Number.between(from: 1950, to: 2024) }
    description { Faker::Lorem.paragraph }
    association :user
  end
end
