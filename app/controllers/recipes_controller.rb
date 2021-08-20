class RecipesController < ApplicationController
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

  private

  def recipesform_params
    params.require(:recipes_form).permit(:title, :image, :category_id, :text, names: [], amounts: [])
          .merge(user_id: current_user.id)
  end
end
