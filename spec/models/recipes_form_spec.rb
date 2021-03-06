require 'rails_helper'

RSpec.describe RecipesForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @recipes_form = FactoryBot.build(:recipes_form, user_id: @user.id)
    @recipes_form.image = fixture_file_upload('public/images/test_image.jpg')
  end

  describe 'プロフィール登録' do
    context '登録できるとき' do
      it 'title,image,category_id,names,amounts,userがあれば登録できる' do
        expect(@recipes_form).to be_valid
      end

      it 'namesに空白の文字列が含まれていても登録できる' do
        @recipes_form.names[0] = ''
        expect(@recipes_form).to be_valid
      end

      it 'amountsに空白の文字列が含まれていても登録できる' do
        @recipes_form.amounts[0] = ''
        expect(@recipes_form).to be_valid
      end
    end

    context '登録できないとき' do
      it 'titleがないと登録できない' do
        @recipes_form.title = ''
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('タイトルを入力してください')
      end

      it 'category_idがないと登録できない' do
        @recipes_form.category_id = nil
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('カテゴリーを入力してください')
      end

      it 'imageがないと登録できない' do
        @recipes_form.image = nil
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('写真を入力してください')
      end

      it 'textがないと登録できない' do
        @recipes_form.text = ''
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('作り方を入力してください')
      end

      it 'userがないと登録できない' do
        @recipes_form.user_id = nil
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'category_idは半角数字以外は登録できない' do
        @recipes_form.category_id = 'a'
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('カテゴリーを入力してください')
      end

      it 'category_idは1は登録できない' do
        @recipes_form.category_id = 1
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('カテゴリーを入力してください')
      end

      it '1つも文字列を含まないnamesは登録できない' do
        @recipes_form.names.clear
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('材料を入力してください')
      end

      # ローカル環境でkuromojiを導入する場合
      # it 'namesの各項目は全角かなカナ漢字以外は登録できない' do
      #   @recipes_form.names.clear
      #   @recipes_form.names << 's蕎麦'
      #   @recipes_form.valid?
      #   expect(@recipes_form.errors.full_messages).to include('材料は不正な値です')
      # end

      # romajiのみを利用する場合
      it 'namesの各項目は全角かなカナ以外は登録できない' do
        @recipes_form.names.clear
        @recipes_form.names << 'sそば'
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('材料は不正な値です')
      end

      it '1つも文字列を含まないamountsは登録できない' do
        @recipes_form.amounts.clear
        @recipes_form.valid?
        expect(@recipes_form.errors.full_messages).to include('分量を入力してください')
      end
    end
  end
end
