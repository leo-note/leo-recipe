require 'rails_helper'

RSpec.describe 'ユーザープロフィール登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'プロフィール登録できるとき' do
    it 'プロフィール編集画面で性別、家族構成、味の好み、アレルギーを入力すると登録できる' do
      # ログインする
      sign_in(@user)
      # マイページリンクからマイページへ移動する
      visit user_path(@user.id)
      # マイページの「プロフィール登録はこちら」からプロフィール登録画面へ遷移する
      expect(page).to have_content('まだプロフィールが登録されていません。登録は')
      visit new_user_profile_path(@user.id)
      # 性別、家族構成、味の好み、アレルギーを入力する
      select '女性', from: 'profile-gender'
      select '１人暮らし', from: 'profile-family-structure'
      select '薄味が好き', from: 'profile-taste'
      fill_in 'profiles_form_name', with: 'タマゴ'
      # 登録ボタンを押すとプロフィールモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Profile.count }.by(1)
      # マイページへ遷移したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # 登録内容が表示されていることを確認する
      expect(page).to have_content('タマゴ')
    end
  end
  context 'プロフィール登録できないとき' do
    it '入力内容を間違えるとエラーメッセージを表示し、同じページに戻る' do
      # ログインする
      sign_in(@user)
      # マイページリンクからマイページへ移動する
      visit user_path(@user.id)
      # マイページの「プロフィール登録はこちら」からプロフィール登録画面へ遷移する
      expect(page).to have_content('まだプロフィールが登録されていません。登録は')
      visit new_user_profile_path(@user.id)
      # 性別、家族構成、味の好み、アレルギーを入力する
      select '--', from: 'profile-gender'
      select '--', from: 'profile-family-structure'
      select '--', from: 'profile-taste'
      fill_in 'profiles_form_name', with: ''
      # 登録ボタンを押してもプロフィールモデルのカウントは上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Profile.count }.by(0)
      # プロフィール登録ページへ戻されることを確認する
      expect(current_path).to eq user_profiles_path(@user.id)
    end
  end
end
