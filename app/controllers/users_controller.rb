class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    # アレルギー食品の情報を取得する
    if @user.profile != nil
      @allergies = Allergy.where(profile_id: @user.profile.id)

      if @allergies.length != 0
        # 現状の仕様では1食材しか登録できないため配列の１つ目の要素を取得する
        materials = @allergies[0].materials
        @material = materials[0]
      end
    end
  end
end
