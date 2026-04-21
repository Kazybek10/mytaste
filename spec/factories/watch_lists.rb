FactoryBot.define do
  factory :watch_list do
    association :user
    name { Faker::Lorem.words(number: 2).join(" ").capitalize }
  end
end
