class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_page, only: [:new, :create]

  def new
    @profiles_form = ProfilesForm.new
  end

  def create
    @profiles_form = ProfilesForm.new(profilesform_params)

    if @profiles_form.valid?
      @profiles_form.save
      redirect_to user_path(params[:user_id])
    else
      render :new
    end
  end

  private

  def move_page
    # 自分以外のユーザーのページへの遷移は回避する
    if current_user.id != params[:user_id].to_i
      redirect_to root_path
    end
  end

  def profilesform_params
    params.require(:profiles_form).permit(:gender_id, :family_structure_id, :taste_id, :name)
          .merge(user_id: params[:user_id])
  end
end
