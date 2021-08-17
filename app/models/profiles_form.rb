class ProfilesForm
  require 'romaji/core_ext/string'

  include ActiveModel::Model
  attr_accessor :user_id, :gender_id, :family_structure_id, :taste_id, :name, :roman_name

  # 必須チェック
  with_options presence: true do
    validates :user_id
    validates :gender_id
    validates :family_structure_id
    validates :taste_id
  end
  # activehash 半角数字以外・「---」の時は保存できない
  with_options numericality: { other_than: 1 } do
    validates :gender_id
    validates :family_structure_id
    validates :taste_id
  end
  # materialのname 全角入力チェック
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }, if: :name_check do
    validates :name
  end

  def name_check
    name != ""
  end

  def save
    profile = Profile.create(user_id: user_id, gender_id: gender_id, family_structure_id: family_structure_id, taste_id: taste_id)

    # アレルギー食品の入力があれば登録する
    if name != ''
      allergy = Allergy.create(profile_id: profile.id)

      # 食材のローマ字読みを取得
      roman_name = (Zipang.to_slug name.romaji).gsub(/\-/, '')
      materials = Material.where(roman_name: roman_name)
      # materialテーブルに登録済みの食品か確認する
      if materials.length == 0
        material = Material.create(name: name, roman_name: roman_name)
        AllergyMaterial.create(allergy_id: allergy.id, material_id: material.id)
      else
        AllergyMaterial.create(allergy_id: allergy.id, material_id: materials[0].id)
      end
    end
  end
end