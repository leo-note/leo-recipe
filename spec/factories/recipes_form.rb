FactoryBot.define do
  factory :recipes_form do
    title                 { Faker::Lorem.word }
    category_id           { Faker::Number.between(from: 2, to: 6) }
    text                  { Faker::Lorem.word }
    names                 { [Gimei.last.hiragana, Gimei.last.hiragana, Gimei.last.hiragana] }
    amounts               { [Faker::Lorem.word, Faker::Lorem.word, Faker::Lorem.word] }
  end
end
