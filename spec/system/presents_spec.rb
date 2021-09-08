require 'rails_helper'

RSpec.describe 'プレゼント申し込み', type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)

    5.times do
      recipe_post(@user)
    end
    @present_order_form = FactoryBot.build(:present_order_form, user_id: @user.id)
  end
  context 'プレゼント申し込みができるとき' do
    it 'プレゼント交換ページで欲しい商品を選び、必要事項を入力するとプレゼント配送の申し込みができる' do
      # ログインする
      sign_in(@user)
      # マイページリンクからマイページへ移動する
      visit user_path(@user.id)
      # マイページの「プレゼント申し込みはこちら」からプレゼント申し込み画面へ遷移する
      expect(page).to have_content('申し込みは')
      visit new_user_present_order_path(@user.id)
      # 必要事項を入力する
      select '国産フルーツジャム', from: 'present_order_form_present_id'
      fill_in 'present_order_form_last_name', with: @present_order_form.last_name
      fill_in 'present_order_form_first_name', with: @present_order_form.first_name
      fill_in 'present_order_form_last_name_kana', with: @present_order_form.last_name_kana
      fill_in 'present_order_form_first_name_kana', with: @present_order_form.first_name_kana
      fill_in 'present_order_form_postal_code', with: @present_order_form.postal_code
      select '東京都', from: 'present_order_form_prefecture_id'
      fill_in 'present_order_form_city', with: @present_order_form.city
      fill_in 'present_order_form_address', with: @present_order_form.address
      fill_in 'present_order_form_building_name', with: @present_order_form.building_name
      fill_in 'present_order_form_phone_number', with: @present_order_form.phone_number
      # 登録ボタンを押すとプレゼントオーダーモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { PresentOrder.count }.by(1)
      # マイページへ遷移したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # 登録内容が表示されていることを確認する
      expect(page).to have_content('国産フルーツジャム')
    end
  end
  context 'プレゼント申し込みができないとき' do
    it '入力内容に誤りがあるとエラーメッセージを表示し、同じページに遷移する' do
      # ログインする
      sign_in(@user)
      # マイページリンクからマイページへ移動する
      visit user_path(@user.id)
      # マイページの「プレゼント申し込みはこちら」からプレゼント申し込み画面へ遷移する
      expect(page).to have_content('申し込みは')
      visit new_user_present_order_path(@user.id)
      # 必要事項を入力する
      select '--', from: 'present_order_form_present_id'
      fill_in 'present_order_form_last_name', with: ''
      fill_in 'present_order_form_first_name', with: ''
      fill_in 'present_order_form_last_name_kana', with: ''
      fill_in 'present_order_form_first_name_kana', with: ''
      fill_in 'present_order_form_postal_code', with: ''
      select '--', from: 'present_order_form_prefecture_id'
      fill_in 'present_order_form_city', with: ''
      fill_in 'present_order_form_address', with: ''
      fill_in 'present_order_form_building_name', with: ''
      fill_in 'present_order_form_phone_number', with: ''
      # 登録ボタンを押してもプレゼントオーダーモデルのカウントが上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { PresentOrder.count }.by(0)
      # プレゼント申し込み画面へ戻されることを確認する
      expect(current_path).to eq(user_present_orders_path(@user.id))
    end
  end
end
