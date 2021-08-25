FactoryBot.define do
  factory :comment do
    text               { Faker::Lorem.word }
    association :user
    association :recipe
  end
end
