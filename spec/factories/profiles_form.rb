FactoryBot.define do
  factory :profiles_form do
    gender_id             { Faker::Number.between(from: 2, to: 4) }
    family_structure_id   { Faker::Number.between(from: 2, to: 5) }
    taste_id              { Faker::Number.between(from: 2, to: 5) }
    name                  { Gimei.last.hiragana }
  end
end
