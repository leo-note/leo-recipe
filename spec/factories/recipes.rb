FactoryBot.define do
  factory :recipe do
    title                 { Faker::Lorem.word }
    category_id           { Faker::Number.between(from: 2, to: 6) }
    text                  { Faker::Lorem.word }
  end
end
