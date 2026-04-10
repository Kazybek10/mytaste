FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    ingredients { Faker::Food.ingredient + ", " + Faker::Food.ingredient + ", " + Faker::Food.ingredient }
    instructions { Faker::Lorem.paragraph(sentence_count: 5) }
    association :user
  end
end
