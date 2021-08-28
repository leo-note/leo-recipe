class PresentOrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_page, only: [:new, :create]

  def new
    @present_order_form = PresentOrderForm.new
    @presents = Present.all
  end

  def create
    @present_order_form = PresentOrderForm.new(presentform_params)

    if @present_order_form.valid?
      @present_order_form.save
      redirect_to user_path(params[:user_id])
    else
      @presents = Present.all
      render :new
    end
  end

  private

  def move_page
    user = User.find(params[:user_id])

    if current_user.id != user.id
      redirect_to root_path
    end
  end

  def presentform_params
    params.require(:present_order_form)
          .permit(:present_id, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code,
                  :prefecture_id, :city, :address, :building_name, :phone_number)
          .merge(user_id: params[:user_id])
  end
end
