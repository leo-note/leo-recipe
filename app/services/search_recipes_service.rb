class SearchRecipesService
  # おすすめレシピの検索
  def self.recommend_search(user_id, taste_id)
    recommend_recipes = []
    similar_users = User.joins(:profile).where(profiles: { taste_id: taste_id })

    similar_users.each do |user|
      # 自分が投稿したレシピはおすすめに含めない
      unless user.id == user_id
        user.recipes.each do |recipe|
          recommend_recipes << recipe
        end
      end
    end

    return recommend_recipes
  end

  # 通常の検索メソッド
  def self.search(keyword, category)
    # ローカル環境でkuromojiを導入する場合
    # keyword_roman = (Zipang.to_slug keyword.romaji).gsub(/\-/, '')
    # romajiのみを利用する場合
    keyword_roman = keyword.romaji
    recipes = Recipe.joins(:materials).where('roman_name LIKE(?)', "%#{keyword_roman}%")

    # カテゴリーの指定がある場合はそのカテゴリーのレシピのみ出力する
    if category != 1
      category_recipes = category_recipe_search(recipes, category)
    else
      return recipes
    end
  end

  # 検索ワードなし検索メソッド
  def self.no_word_search(category)
    Recipe.where(category_id: category)
  end

  # アレルギー食材を含むレシピは除外するメソッド
  def self.allergy_search(recipes, material)
    recipes_result = []

    recipes.each do |recipe|
      recipe_flg = 0

      recipe.materials.each do |m|
        if m.roman_name == material.roman_name
          recipe_flg = 1
        end
      end

      if recipe_flg.zero?
        recipes_result << recipe
      end
    end
    return recipes_result
  end

  # カテゴリー検索
  def self.category_recipe_search(recipes, category)
    category_recipes = []

    recipes.each do |recipe|
      if recipe.category_id == category
        category_recipes << recipe
      end
    end

    return category_recipes
  end
end
