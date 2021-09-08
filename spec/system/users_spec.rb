require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '新規登録画面でニックネーム、メールアドレス、パスワードを入力するとユーザー登録できる' do
      # トップページに移動する
      visit root_path
      # ヘッダーリンクから新規登録ページへ移動する
      expect(page).to have_content('新規会員登録')
      visit new_user_registration_path
      # ニックネーム、メールアドレス、パスワード、パスワード(確認用)を入力する
      fill_in 'ユーザーネーム', with: @user.nickname
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード（確認用）', with: @user.password_confirmation
      # 登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンが存在することを確認する
      expect(page).to have_content('ログアウト')
      # 「新規会員登録」ボタンと「ログアウト」ボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規会員登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '入力内容を間違えるとエラーメッセージを表示し、同じページに戻る' do
      # トップページに移動する
      visit root_path
      # ヘッダーリンクから新規登録ページへ移動する
      expect(page).to have_content('新規会員登録')
      visit new_user_registration_path
      # ニックネーム、メールアドレス、パスワード、パスワード(確認用)を入力する
      fill_in 'ユーザーネーム', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（確認用）', with: ''
      # 登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ユーザーログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it 'ログイン画面でメールアドレス、パスワードを入力するとログインできる' do
      # トップページに移動する
      visit root_path
      # ヘッダーリンクからログインページへ遷移する
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      # メールアドレス、パスワードを入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンが存在することを確認する
      expect(page).to have_content('ログアウト')
      # 新規会員登録ボタンやログインボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規会員登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '入力内容を間違えるとエラーメッセージを表示し、同じページに戻る' do
      # トップページに移動する
      visit root_path
      # ヘッダーリンクからログインページへ遷移する
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      # メールアドレス、パスワードを入力する
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq user_session_path
    end
  end
end

RSpec.describe 'ユーザーマイページ', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'マイページの確認' do
    it 'ログイン状態ではマイページへ遷移できる' do
      # ログインする
      sign_in(@user)
      # トップページのマイページリンクからマイページへ移動する
      expect(page).to have_content('さん、こんにちは！')
      visit user_path(@user.id)
      # フォロー情報、ログイン情報、プロフィール、プレゼント申込履歴、クリップしたレシピ、投稿したレシピが存在することを確認する
      expect(page).to have_content('フォロー中')
      expect(page).to have_content('ログイン情報')
      expect(page).to have_content('プロフィール')
      expect(page).to have_content('プレゼント申込履歴')
      expect(page).to have_content('クリップしたレシピ')
      expect(page).to have_content('投稿したレシピ')
    end
    it 'ログアウト状態ではマイページへ遷移できない' do
      # トップページに移動する
      visit new_user_session_path
      # トップページにマイページリンクがないことを確認する
      expect(page).to have_no_content('さん、こんにちは！')
    end
  end
  context '他ユーザーのマイページ確認' do
    it 'ログイン状態で他ユーザーのマイページを確認できる' do
      another_user = FactoryBot.create(:user)
      # ログインする
      sign_in(@user)
      # 他ユーザーのマイページリンクから他ユーザーのマイページへ移動する
      visit user_path(another_user.id)
      # フォロワー情報、投稿したレシピが存在することを確認する
      expect(page).to have_content('フォロワー')
      expect(page).to have_content('投稿したレシピ')
      # ログイン情報、プロフィール、プレゼント申込履歴、クリップしたレシピが存在しないことを確認する
      expect(page).to have_no_content('ログイン情報')
      expect(page).to have_no_content('プロフィール')
      expect(page).to have_no_content('プレゼント申込履歴')
      expect(page).to have_no_content('クリップしたレシピ')
    end
    it 'ログアウト状態で他ユーザーのマイページを確認できる' do
      another_user = FactoryBot.create(:user)
      # 他ユーザーのマイページリンクから他ユーザーのマイページへ移動する
      visit user_path(another_user.id)
      # フォロワー情報、投稿したレシピが存在することを確認する
      expect(page).to have_content('フォロワー')
      expect(page).to have_content('投稿したレシピ')
      # ログイン情報、プロフィール、プレゼント申込履歴、クリップしたレシピが存在しないことを確認する
      expect(page).to have_no_content('ログイン情報')
      expect(page).to have_no_content('プロフィール')
      expect(page).to have_no_content('プレゼント申込履歴')
      expect(page).to have_no_content('クリップしたレシピ')
    end
  end
end

RSpec.describe 'ユーザーフォロー', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)

    sign_in(@another_user)
    @recipes_form = recipe_post(@another_user)
    click_link 'ログアウト'
  end
  context 'フォローできるとき' do
    it 'ログイン状態ではユーザーをフォローできる', js: true do
      # ログインする
      sign_in(@user)
      # 他ユーザーのマイページリンクから他ユーザーのマイページへ移動する
      visit user_path(@another_user.id)
      # フォローボタンを押すとフォローモデルのカウントが上がることを確認する
      expect {
        find('div[id="follow_btn"]').click
        sleep 1.5
      }.to change { Follow.count }.by(1)
      # 自分のマイページに移動する
      visit user_path(@user.id)
      # フォロー中の表示があることを確認する
      expect(page).to have_content('フォロー中')
      # フォロー中ユーザーの詳細確認ページへ遷移する
      visit user_follows_path(@user.id)
      # フォローしたユーザーのレシピが表示されていることを確認する
      expect(page).to have_content(@recipes_form.title)
      # 他ユーザーのマイページリンクから他ユーザーのマイページへ移動する
      visit user_path(@another_user.id)
      # フォロー済みマークが表示されていることを確認する
      expect(page).to have_selector '.bi-star-fill'
    end
  end
  context 'フォローできないとき' do
    it 'ログアウト状態ではユーザーフォローできない' do
      # 他ユーザーのマイページリンクから他ユーザーのマイページへ移動する
      visit user_path(@another_user.id)
      # フォローボタンが表示されていないことを確認する
      expect(page).to have_no_selector 'div[id="follow_btn"]'
    end
    it '自分自身はフォローできない' do
      # ログインする
      sign_in(@user)
      # マイページリンクからマイページへ移動する
      visit user_path(@user.id)
      # フォローボタンが表示されていないことを確認する
      expect(page).to have_no_selector 'div[id="follow_btn"]'
    end
  end
end

RSpec.describe 'おすすめユーザーの確認', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)

    sign_in(@another_user)
    @recipes_form = recipe_post(@another_user)

    profile_register(@another_user)
  end
  context 'おすすめユーザーが表示されるとき' do
    it 'プロフィール登録し、同じプロフィール情報を持つユーザーが存在する場合はおすすめが表示される' do
      # ログインする
      sign_in(@user)
      # プロフィール登録する
      profile_register(@user)
      # 自分のマイページに移動する
      visit user_path(@user.id)
      # フォロー中の表示があることを確認する
      expect(page).to have_content('フォロー中')
      # フォロー中ユーザーの詳細確認ページへ遷移する
      visit user_follows_path(@user.id)
      # おすすめユーザーのレシピが表示されていることを確認する
      expect(page).to have_content(@recipes_form.title)
    end
  end
  context 'おすすめユーザーが表示されないとき' do
    it 'プロフィール登録がない場合、おすすめユーザーのレシピは表示されない' do
      # ログインする
      sign_in(@user)
      # 自分のマイページに移動する
      visit user_path(@user.id)
      # フォロー中の表示があることを確認する
      expect(page).to have_content('フォロー中')
      # フォロー中ユーザーの詳細確認ページへ遷移する
      visit user_follows_path(@user.id)
      # おすすめユーザーのレシピが表示されないことを確認する
      expect(page).to have_no_content(@recipes_form.title)
    end
    it 'プロフィール登録しても、同じプロフィール情報を持つユーザーがない場合おすすめユーザーのレシピは表示されない' do
      # ログインする
      sign_in(@user)
      # another_userと異なる情報でプロフィール登録する
      visit new_user_profile_path(@user.id)
      select '男性', from: 'profile-gender'
      select '１人暮らし', from: 'profile-family-structure'
      select '薄味が好き', from: 'profile-taste'
      fill_in 'profiles_form_name', with: ''
        expect {
        find('input[name="commit"]').click
      }.to change { Profile.count }.by(1)
      expect(current_path).to eq(user_path(@user.id))
      # 自分のマイページに移動する
      visit user_path(@user.id)
      # フォロー中の表示があることを確認する
      expect(page).to have_content('フォロー中')
      # フォロー中ユーザーの詳細確認ページへ遷移する
      visit user_follows_path(@user.id)
      # おすすめユーザーのレシピが表示されないことを確認する
      expect(page).to have_no_content(@recipes_form.title)
    end
  end
end
