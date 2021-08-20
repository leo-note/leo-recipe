require 'rails_helper'

RSpec.describe ProfilesForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @profiles_form = FactoryBot.build(:profiles_form, user_id: @user.id)
  end

  describe 'プロフィール登録' do
    context '登録できるとき' do
      it 'gender_id,family_structure_id,taste_id,userがあれば登録できる' do
        expect(@profiles_form).to be_valid
      end

      it 'nameはなくても登録できる' do
        @profiles_form.name = ''
        expect(@profiles_form).to be_valid
      end
    end

    context '登録できないとき' do
      it 'gender_idがないと登録できない' do
        @profiles_form.gender_id = nil
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Gender can't be blank")
      end

      it 'family_structure_idがないと登録できない' do
        @profiles_form.family_structure_id = nil
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Family structure can't be blank")
      end

      it 'taste_idがないと登録できない' do
        @profiles_form.taste_id = nil
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Taste can't be blank")
      end

      it 'userがないと登録できない' do
        @profiles_form.user_id = nil
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("User can't be blank")
      end

      it 'gender_idは半角数字以外は登録できない' do
        @profiles_form.gender_id = 'a'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Gender is not a number")
      end

      it 'family_structure_idは半角数字以外は登録できない' do
        @profiles_form.family_structure_id = 'a'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Family structure is not a number")
      end

      it 'taste_idは半角数字以外は登録できない' do
        @profiles_form.taste_id = 'a'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Taste is not a number")
      end

      it 'gender_idは1は登録できない' do
        @profiles_form.gender_id = 1
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Gender must be other than 1")
      end

      it 'family_structure_idは1は登録できない' do
        @profiles_form.family_structure_id = 1
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Family structure must be other than 1")
      end

      it 'taste_idは1は登録できない' do
        @profiles_form.taste_id = 1
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Taste must be other than 1")
      end

      # ローカル環境でrjbを導入する場合
      # it 'nameは全角かなカナ漢字以外は登録できない' do
      #   @profiles_form.name = 's蕎麦'
      #   @profiles_form.valid?
      #   expect(@profiles_form.errors.full_messages).to include("Name is invalid")
      # end

      # romajiのみを利用する場合
      it 'nameは全角かなカナ以外は登録できない' do
        @profiles_form.name = 'sそば'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include("Name is invalid")
      end
    end
  end
end
