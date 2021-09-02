class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @recipes = Recipe.includes(:user).order('created_at DESC')
    @recommend_recipes = []

    # ログイン状態で、プロフィール登録済みのユーザーにはおすすめレシピを表示する
    if user_signed_in? && !current_user.profile.nil?
      @taste = current_user.profile.taste.name

      taste_id = current_user.profile.taste.id
      @recommend_recipes = SearchRecipesService.recommend_search(current_user.id, taste_id)
    end
  end

  def new
    @recipes_form = RecipesForm.new
  end

  def create
    @recipes_form = RecipesForm.new(recipesform_params)

    if @recipes_form.valid?
      @recipes_form.save
      redirect_to root_path
    else
      # JSに渡すデータを定義
      gon.names = @recipes_form.names
      gon.amounts = @recipes_form.amounts
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    if user_signed_in?
      @clip = Clip.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    end
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user).order('created_at DESC')

    # JSに渡す変数を定義
    gon.receipe_id = @recipe.id
  end

  def search
    @keyword = params[:keyword]
    @category = Category.find(params[:category_id])

    if params[:keyword] == '' && params[:category_id].nil?
      # 検索ワード・カテゴリーの入力がない場合、検索を行わない
      @recepes = []
    else
      # アレルギー有無の判定
      if user_signed_in? && !current_user.profile.nil? && !current_user.profile.allergy.nil?
        # アレルギー食材登録がある場合、その食材を含むレシピは除く
        allergies = Allergy.where(profile_id: current_user.profile.id)
        # 現状の仕様では1食材しか登録できないため配列の１つ目の要素を取得する
        materials = allergies[0].materials
        material = materials[0]

        if params[:keyword] == ''
          # 検索ワードの入力がない場合、カテゴリのみで検索を行う
          recipes = SearchRecipesService.no_word_search(@category.id)
        else
          recipes = SearchRecipesService.search(@keyword, @category.id)
        end
        @recipes = SearchRecipesService.allergy_search(recipes, material)
      else

        if params[:keyword] == ''
          # 検索ワードの入力がない場合、カテゴリのみで検索を行う
          @recipes = SearchRecipesService.no_word_search(@category.id)
        else
          @recipes = SearchRecipesService.search(@keyword, @category.id)
        end
      end
    end
  end

  private

  def recipesform_params
    params.require(:recipes_form).permit(:title, :image, :category_id, :text, names: [], amounts: [])
          .merge(user_id: current_user.id)
  end
end
