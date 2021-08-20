class RecipesForm
  require 'romaji/core_ext/string'

  include ActiveModel::Model
  attr_accessor :user_id, :title, :category_id, :image, :text, :names, :amounts

  # 必須チェック
  with_options presence: true do
    validates :user_id
    validates :title
    validates :category_id
    validates :image
    validates :text
  end
  # activehash 半角数字以外・「---」の時は保存できない
  with_options numericality: { other_than: 1 } do
    validates :category_id
  end
  # names 文字種、入力なしのチェック
  validate :names_check
  def names_check
    blank_flg = 0

    names.each do |name|
      if name != ''
        blank_flg = 1

        # ローカル環境でrjbを導入する場合 全角以外は登録できない
        # if name.match(/\A[ぁ-んァ-ヶ一-龥々ー]+\z/).nil?
        # romajiのみを利用する場合 全角かなカナ以外は登録できない
        if name.match(/\A[ぁ-んァ-ヶー]+\z/).nil?
          errors.add(:names, "is invalid")
          names.clear
        end
      end
    end

    if blank_flg.zero?
      errors.add(:names, "can't be blank")
      names.clear
    end
  end
  # amounts 入力なしのチェック
  validate :amounts_check
  def amounts_check
    blank_flg = 0

    amounts.each do |amount|
      if amount != ''
        blank_flg = 1
      end
    end

    if blank_flg.zero?
      errors.add(:amounts, "can't be blank")
      amounts.clear
    end
  end

  def save
    recipe = Recipe.create(user_id: user_id, title: title, image: image, category_id: category_id, text: text)

    names.length.times do |i|
      # 食材に入力がないカラムは登録しない
      unless names[i] == ''
        # 食材のローマ字読みを取得
        # ローカル環境でrjbを導入する場合
        # roman_name = (Zipang.to_slug names[i].romaji).gsub(/\-/, '')
        # romajiのみを利用する場合
        roman_name = names[i].romaji
        materials = Material.where(roman_name: roman_name)

        # materialテーブルに登録済みの食品か確認する
        if materials.length == 0
          material = Material.create(name: names[i], roman_name: roman_name)
          RecipeMaterial.create(recipe_id: recipe.id, material_id: material.id, amount: amounts[i])
        else
          RecipeMaterial.create(recipe_id: recipe.id, material_id: materials[0].id, amount: amounts[i])
        end
      end
    end
  end
end
