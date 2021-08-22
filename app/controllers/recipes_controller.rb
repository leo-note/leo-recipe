class RecipesController < ApplicationController
  require 'romaji/core_ext/string'
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @recipes = Recipe.includes(:user).order('created_at DESC')
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
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def search
    @keyword = params[:keyword]

    if user_signed_in? && !current_user.profile.allergy.nil?
      # アレルギー食材登録がある場合、その食材を含むレシピは除く
      allergies = Allergy.where(profile_id: current_user.profile.id)
      # 現状の仕様では1食材しか登録できないため配列の１つ目の要素を取得する
      materials = allergies[0].materials
      material = materials[0]
      @recipes = Recipe.custom_search(@keyword,material)

    else
      @recipes = Recipe.search(@keyword)
    end
  end

  private

  def recipesform_params
    params.require(:recipes_form).permit(:title, :image, :category_id, :text, names: [], amounts: [])
          .merge(user_id: current_user.id)
  end
end
