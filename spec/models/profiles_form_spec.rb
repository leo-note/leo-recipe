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
        expect(@profiles_form.errors.full_messages).to include('性別を入力してください')
      end

      it 'family_structure_idがないと登録できない' do
        @profiles_form.family_structure_id = nil
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('家族構成を入力してください')
      end

      it 'taste_idがないと登録できない' do
        @profiles_form.taste_id = nil
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('味の好みを入力してください')
      end

      it 'userがないと登録できない' do
        @profiles_form.user_id = nil
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'gender_idは半角数字以外は登録できない' do
        @profiles_form.gender_id = 'a'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('性別を入力してください')
      end

      it 'family_structure_idは半角数字以外は登録できない' do
        @profiles_form.family_structure_id = 'a'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('家族構成を入力してください')
      end

      it 'taste_idは半角数字以外は登録できない' do
        @profiles_form.taste_id = 'a'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('味の好みを入力してください')
      end

      it 'gender_idは1は登録できない' do
        @profiles_form.gender_id = 1
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('性別を入力してください')
      end

      it 'family_structure_idは1は登録できない' do
        @profiles_form.family_structure_id = 1
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('家族構成を入力してください')
      end

      it 'taste_idは1は登録できない' do
        @profiles_form.taste_id = 1
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('味の好みを入力してください')
      end

      # ローカル環境でkuromojiを導入する場合
      # it 'nameは全角かなカナ漢字以外は登録できない' do
      #   @profiles_form.name = 's蕎麦'
      #   @profiles_form.valid?
      #   expect(@profiles_form.errors.full_messages).to include('アレルギー食材は不正な値です')
      # end

      # romajiのみを利用する場合
      it 'nameは全角かなカナ以外は登録できない' do
        @profiles_form.name = 'sそば'
        @profiles_form.valid?
        expect(@profiles_form.errors.full_messages).to include('アレルギー食材は不正な値です')
      end
    end
  end
end
