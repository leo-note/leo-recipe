FactoryBot.define do
  factory :clip do
    association :user
    association :recipe
  end
end
