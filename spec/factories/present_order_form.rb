FactoryBot.define do
  factory :present_order_form do
    present_id           { 2 }
    last_name            { Gimei.last.kanji }
    first_name           { Gimei.first.kanji }
    last_name_kana       { Gimei.last.katakana }
    first_name_kana      { Gimei.first.katakana }
    postal_code          { (Faker::Number.number(digits: 7)).to_s.insert(3, '-') }
    prefecture_id        { Faker::Number.between(from: 2, to: 48) }
    city                 { Gimei.city.kanji }
    address              { Gimei.city.to_s }
    building_name        { Gimei.town.to_s }
    phone_number         { (Faker::Number.number(digits: 10)).to_s }
  end
end
