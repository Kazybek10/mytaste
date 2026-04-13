FactoryBot.define do
  factory :user_item do
    association :user
    association :itemable, factory: :movie
    status { "want" }
    rating { nil }
  end
end
