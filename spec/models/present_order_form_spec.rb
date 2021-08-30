require 'rails_helper'

RSpec.describe PresentOrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    5.times do
      FactoryBot.create(:recipe, user_id: @user.id)
    end
    @present_order_form = FactoryBot.build(:present_order_form, user_id: @user.id)
  end

  describe 'プレゼント申し込み' do
    context '申し込みできるとき' do
      it 'present_id,last_name,first_name,last_name_kana,first_name_kana,posta_code,prefecture_id,
          city,address,phone_number,userがあれば登録できる' do
        expect(@present_order_form).to be_valid
      end

      it 'building_nameはなくても登録できる' do
        @present_order_form.building_name = ''
        expect(@present_order_form).to be_valid
      end

      it 'phone_numberは10桁もしくは11桁なら登録できる' do
        # FactoryBotで生成するphone_numberは10桁なので10桁ケースは上記で実施済
        @present_order_form.phone_number = "12345678901"
        expect(@present_order_form).to be_valid
      end
    end

    context '申し込みできないとき' do
      it 'present_idがないと登録できない' do
        @present_order_form.present_id = nil
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('プレゼントを入力してください')
      end

      it 'last_nameがないと登録できない' do
        @present_order_form.last_name = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('姓を入力してください')
      end

      it 'first_nameがないと登録できない' do
        @present_order_form.first_name = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('名を入力してください')
      end

      it 'last_name_kanaがないと登録できない' do
        @present_order_form.last_name_kana = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('姓（カナ）を入力してください')
      end

      it 'first_name_kanaがないと登録できない' do
        @present_order_form.first_name_kana = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('名（カナ）を入力してください')
      end

      it 'postal_codeがないと登録できない' do
        @present_order_form.postal_code = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('郵便番号を入力してください')
      end

      it 'prefecture_idがないと登録できない' do
        @present_order_form.prefecture_id = nil
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('都道府県を入力してください')
      end

      it 'cityがないと登録できない' do
        @present_order_form.city = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('市区町村を入力してください')
      end

      it 'addressがないと登録できない' do
        @present_order_form.address = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('番地を入力してください')
      end

      it 'phone_numberがないと登録できない' do
        @present_order_form.phone_number = ''
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('電話番号を入力してください')
      end

      it 'userがないと登録できない' do
        @present_order_form.user_id = nil
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'present_idは半角数字以外は登録できない' do
        @present_order_form.present_id = 'a'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('プレゼントを入力してください')
      end

      it 'present_idは1は登録できない' do
        @present_order_form.present_id = '1'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('プレゼントを入力してください')
      end

      it 'prefecture_idは半角数字以外は登録できない' do
        @present_order_form.prefecture_id = 'a'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('都道府県を入力してください')
      end

      it 'prefecture_idは1は登録できない' do
        @present_order_form.prefecture_id = 1
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('都道府県を入力してください')
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @present_order_form.last_name = 'abcde'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('姓は不正な値です')
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @present_order_form.first_name = 'abcde'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('名は不正な値です')
      end

      it 'last_name_kanaは全角カタカナ以外は登録できない' do
        @present_order_form.last_name_kana = '山田'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('姓（カナ）は不正な値です')
      end

      it 'first_name_kanaは全角カタカナ以外は登録できない' do
        @present_order_form.first_name_kana = '太朗'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('名（カナ）は不正な値です')
      end

      it 'postal_codeはアルファベットなど「xxx-xxxx」の半角文字列以外は登録できない' do
        @present_order_form.postal_code = '1234aaa'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it 'postal_codeは「-」を含まないなど「xxx-xxxx」の半角文字列以外は登録できない' do
        @present_order_form.postal_code = '1234567'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it 'phone_numberは半角数字以外は登録できない' do
        @present_order_form.phone_number = 'aaaaabbbbb'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('電話番号は数値で入力してください')
      end

      it 'phone_numberは9桁以下だと登録できない' do
        @present_order_form.phone_number = '123456789'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('電話番号は10文字以上で入力してください')
      end

      it 'phone_numberは12桁以上だと登録できない' do
        @present_order_form.phone_number = '123456789012'
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('電話番号は11文字以内で入力してください')
      end

      it '投稿レシピ数がプレゼントの必要数ないと登録できない' do
        @present_order_form.present_id = 3
        @present_order_form.valid?
        expect(@present_order_form.errors.full_messages).to include('このプレゼントの応募には10投稿が必要です')
      end

      it '申し込みしたプレゼントは申し込みできない' do
        @present_order_form.save
        another_present_order_form = FactoryBot.build(:present_order_form, user_id: @user.id)
        another_present_order_form.valid?
        expect(another_present_order_form.errors.full_messages).to include('このプレゼントは申し込み済です。受け取りは１つにつき１回までです')
      end
    end
  end
end
