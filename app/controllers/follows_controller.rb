class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  # CSRF保護を無効化
  skip_forgery_protection

  before_action :set_user, only: [:index, :create]

  def index
    # フォロー中ユーザーの投稿レシピを取得
    followees = current_user.reverse_of_followings
    @recipes =  store_recipes(followees)

    # おすすめユーザーの投稿レシピ取得
    @recommend_user_recipes = []
    unless @user.profile.nil?
      profile = @user.profile
      recommend_users = User.joins(:profile)
                            .where(profiles: { gender_id: profile.gender_id, family_structure_id: profile.family_structure_id,
                                               taste_id: profile.taste_id })
                            .where.not(users: { id: @user.id })
      @recommend_user_recipes =  store_recipes(recommend_users)
    end
  end

  def create
    Follow.create(followee_id: params[:user_id], follower_id: current_user.id)

    followers = @user.followings
    render json: { follower_count: followers.length }
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def store_recipes(users)
    # ユーザー配列から投稿したレシピを1つずつ格納する
    result_recipes = []

    users.each do |user|
      recipes = user.recipes
      recipes.each do |recipe|
        result_recipes << recipe
      end
    end
    return result_recipes
  end
end
