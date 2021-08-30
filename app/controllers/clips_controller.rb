class ClipsController < ApplicationController
  before_action :authenticate_user!, only: :create
  # CSRF保護を無効化
  skip_forgery_protection

  def create
    Clip.create(user_id: current_user.id, recipe_id: params[:recipe_id])

    recipe = Recipe.find(params[:recipe_id])
    render json: { clip_count: recipe.clips.length }
  end
end
