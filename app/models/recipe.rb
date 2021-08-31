class Recipe < ApplicationRecord
  require 'romaji/core_ext/string'

  # アソシエーション
  belongs_to :user
  has_many :recipe_materials
  has_many :materials, through: :recipe_materials
  has_one_attached :image
  has_many :clips
  has_many :comments
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  # 検索メソッド
  def self.custom_search(keyword, material, category)
    if keyword != ''
      # ローカル環境でkuromojiを導入する場合
      # keyword_roman = (Zipang.to_slug keyword.romaji).gsub(/\-/, '')
      # romajiのみを利用する場合
      keyword_roman = keyword.romaji
      recipe_result = Recipe.joins(:materials).where('roman_name LIKE(?)', "%#{keyword_roman}%")
      recipes = []

      # アレルギー食材を含むレシピは除外
      recipe_result.each do |r|
        r_flg = 0

        r.materials.each do |m|
          if m.roman_name == material.roman_name
            r_flg = 1
          end
        end

        if r_flg.zero?
          recipes << r
        end
      end

      # カテゴリーの指定がある場合はそのカテゴリーのレシピのみ出力する
      if category != 1
        category_recipes = category_recipe_search(recipes, category)
        return category_recipes
      else
        return recipes
      end
    end
  end

  def self.search(keyword, category)
    if keyword != ''
      # ローカル環境でkuromojiを導入する場合
      # keyword_roman = (Zipang.to_slug keyword.romaji).gsub(/\-/, '')
      # romajiのみを利用する場合
      keyword_roman = keyword.romaji
      recipes = Recipe.joins(:materials).where('roman_name LIKE(?)', "%#{keyword_roman}%")

      # カテゴリーの指定がある場合はそのカテゴリーのレシピのみ出力する
      if category != 1
        category_recipes = category_recipe_search(recipes, category)
        return category_recipes
      else
        return recipes
      end
    end
  end
end

def category_recipe_search(recipes, category)
  category_recipes = []

  recipes.each do |recipe|
    if recipe.category_id == category
      category_recipes << recipe
    end
  end

  return category_recipes
end
