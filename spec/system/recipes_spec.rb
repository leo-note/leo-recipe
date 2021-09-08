require 'rails_helper'

RSpec.describe 'レシピ投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @recipes_form = FactoryBot.build(:recipes_form, user_id: @user.id)
  end
  context 'レシピ投稿できるとき' do
    it 'レシピ投稿画面で必要項目を入力すると投稿できる' do
      # ログインする
      sign_in(@user)
      # ヘッダーリンクからレシピ投稿ページへ移動する
      expect(page).to have_content('レシピ投稿')
      visit new_recipe_path
      # タイトル、写真、カテゴリー、材料、分量、作り方を入力する
      fill_in 'recipe_title', with: @recipes_form.title
      attach_file 'recipe_image', "#{Rails.root}/public/images/test_image.jpg"
      select '和食', from: 'recipe-category'
      fill_in 'material_name_1', with: @recipes_form.names[0]
      fill_in 'recipe_amount_1', with: @recipes_form.amounts[0]
      fill_in 'material_name_2', with: @recipes_form.names[1]
      fill_in 'recipe_amount_2', with: @recipes_form.amounts[1]
      fill_in 'material_name_3', with: @recipes_form.names[2]
      fill_in 'recipe_amount_3', with: @recipes_form.amounts[2]
      fill_in 'recipe_text', with: @recipes_form.text
      # 登録ボタンを押すとレシピモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 投稿したレシピが存在することを確認する
      expect(page).to have_content(@recipes_form.title)
    end
  end
  context 'レシピ投稿できないとき' do
    it '入力内容を間違えるとエラーメッセージを表示し、同じページに戻る' do
      # ログインする
      sign_in(@user)
      # ヘッダーリンクからレシピ投稿ページへ移動する
      expect(page).to have_content('レシピ投稿')
      visit new_recipe_path
      # タイトル、写真、カテゴリー、材料、分量、作り方を入力する
      fill_in 'recipe_title', with: ''
      attach_file 'recipe_image', "#{Rails.root}/public/images/test_image.jpg"
      select '--', from: 'recipe-category'
      fill_in 'material_name_1', with: ''
      fill_in 'recipe_amount_1', with: ''
      fill_in 'material_name_2', with: ''
      fill_in 'recipe_amount_2', with: ''
      fill_in 'material_name_3', with: ''
      fill_in 'recipe_amount_3', with: ''
      fill_in 'recipe_text', with: ''
      # 登録ボタンを押してもレシピモデルのカウントが上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(0)
      # レシピ投稿画面へ戻されることを確認する
      expect(current_path).to eq(recipes_path)
    end
  end
end

RSpec.describe 'レシピ詳細表示', type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)
    @recipes_form = recipe_post(@user)
  end
  context 'レシピ詳細表示' do
    it 'レシピの写真をクリックすると、材料や作り方など詳細情報を表示する' do
      # ログインする
      sign_in(@user)
      # レシピカードが表示されていることを確認する
      expect(page).to have_content(@recipes_form.title)
      # クリックしてレシピ詳細ページへ移動する
      click_on @recipes_form.title
      # タイトル、材料、作り方が存在することを確認する
      expect(page).to have_content(@recipes_form.title)
      expect(page).to have_content(@recipes_form.names[0])
      expect(page).to have_content(@recipes_form.amounts[0])
      expect(page).to have_content(@recipes_form.text)
    end
  end
end

RSpec.describe 'レシピ検索', type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)
    @recipes_form = recipe_post(@user)
  end
  context '検索結果が表示されるとき' do
    it 'レシピカテゴリで検索できる' do
      # トップページへ移動する
      visit root_path
      # 検索フォームが存在することを確認する
      expect(page).to have_selector 'select[id="category_id"]'
      expect(page).to have_selector 'input[id="keyword"]'
      # レシピカテゴリを入力する
      select '和食', from: 'category_id'
      # 検索ボタンを押下する
      click_on '検索'
      # 検索結果ページへ遷移したことを確認する
      expect(current_path).to eq(search_recipes_path)
      # 検索結果が表示されていることを確認する
      expect(page).to have_content('和食')
      expect(page).to have_content(@recipes_form.title)
    end
    it '食材名で検索できる' do
      # トップページへ移動する
      visit root_path
      # 検索フォームが存在することを確認する
      expect(page).to have_selector 'select[id="category_id"]'
      expect(page).to have_selector 'input[id="keyword"]'
      # 食材名を入力する
      fill_in 'keyword', with: @recipes_form.names[0]
      # 検索ボタンを押下する
      click_on '検索'
      # 検索結果ページへ遷移したことを確認する
      expect(current_path).to eq(search_recipes_path)
      # 検索結果が表示されていることを確認する
      expect(page).to have_content(@recipes_form.names[0])
      expect(page).to have_content(@recipes_form.title)
    end
    it 'レシピカテゴリと食材名で検索できる' do
      # トップページへ移動する
      visit root_path
      # 検索フォームが存在することを確認する
      expect(page).to have_selector 'select[id="category_id"]'
      expect(page).to have_selector 'input[id="keyword"]'
      # レシピカテゴリと食材名を入力する
      select '和食', from: 'category_id'
      fill_in 'keyword', with: @recipes_form.names[0]
      # 検索ボタンを押下する
      click_on '検索'
      # 検索結果ページへ遷移したことを確認する
      expect(current_path).to eq(search_recipes_path)
      # 検索結果が表示されていることを確認する
      expect(page).to have_content('和食')
      expect(page).to have_content(@recipes_form.names[0])
      expect(page).to have_content(@recipes_form.title)
    end
    it 'アレルギー食材を登録していると、その食材を含まない結果を表示する' do
      # ログインする
      sign_in(@user)
      # レシピを投稿する
      another_recipes_form = recipe_post(@user)
      # 投稿したレシピに含まれる食材をアレルギー登録する
      visit new_user_profile_path(@user.id)
      select '女性', from: 'profile-gender'
      select '１人暮らし', from: 'profile-family-structure'
      select '薄味が好き', from: 'profile-taste'
      fill_in 'profiles_form_name', with: another_recipes_form.names[0]
      expect {
        find('input[name="commit"]').click
      }.to change { Profile.count }.by(1)
      expect(current_path).to eq(user_path(@user.id))
      # トップページへ移動する
      visit root_path
      # 検索フォームが存在することを確認する
      expect(page).to have_selector 'select[id="category_id"]'
      expect(page).to have_selector 'input[id="keyword"]'
      # レシピカテゴリを入力する
      select '和食', from: 'category_id'
      # 検索ボタンを押下する
      click_on '検索'
      # 検索結果ページへ遷移したことを確認する
      expect(current_path).to eq(search_recipes_path)
      # 検索結果が表示されていることを確認する
      expect(page).to have_content('和食')
      expect(page).to have_content(@recipes_form.title)
      # アレルギー食材を含むレシピは表示されないことを確認する
      expect(page).to have_no_content(another_recipes_form.title)
    end
  end
  context '検索結果が表示されないとき' do
    it 'レシピカテゴリで検索しても、該当レシピがない場合は結果が表示されない' do
      # トップページへ移動する
      visit root_path
      # 検索フォームが存在することを確認する
      expect(page).to have_selector 'select[id="category_id"]'
      expect(page).to have_selector 'input[id="keyword"]'
      # レシピカテゴリを入力する
      select '洋食', from: 'category_id'
      # 検索ボタンを押下する
      click_on '検索'
      # 検索結果ページへ遷移したことを確認する
      expect(current_path).to eq(search_recipes_path)
      # 検索結果が表示されないことを確認する
      expect(page).to have_no_content('洋食')
      # 「検索結果はありません」と表示されることを確認する
      expect(page).to have_content('検索結果はありません')
    end
    it '食材名で検索しても、該当レシピがない場合は結果が表示されない' do
      # トップページへ移動する
      visit root_path
      # 検索フォームが存在することを確認する
      expect(page).to have_selector 'select[id="category_id"]'
      expect(page).to have_selector 'input[id="keyword"]'
      # 食材名を入力する
      fill_in 'keyword', with: 'たまご'
      # 検索ボタンを押下する
      click_on '検索'
      # 検索結果ページへ遷移したことを確認する
      expect(current_path).to eq(search_recipes_path)
      # 検索結果が表示されないことを確認する
      expect(page).to have_no_content('たまご')
      # 「検索結果はありません」と表示されることを確認する
      expect(page).to have_content('検索結果はありません')
    end
    it 'レシピカテゴリと食材名で検索しても、該当レシピがない場合は結果が表示されない' do
      # トップページへ移動する
      visit root_path
      # 検索フォームが存在することを確認する
      expect(page).to have_selector 'select[id="category_id"]'
      expect(page).to have_selector 'input[id="keyword"]'
      # レシピカテゴリと食材名を入力する
      select '洋食', from: 'category_id'
      fill_in 'keyword', with: 'たまご'
      # 検索ボタンを押下する
      click_on '検索'
      # 検索結果ページへ遷移したことを確認する
      expect(current_path).to eq(search_recipes_path)
      # 検索結果が表示されないことを確認する
      expect(page).to have_no_content('洋食')
      expect(page).to have_no_content('たまご')
      # 「検索結果はありません」と表示されることを確認する
      expect(page).to have_content('検索結果はありません')
    end
  end
end

RSpec.describe 'レシピクリップ', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)

    sign_in(@another_user)
    @recipes_form = recipe_post(@another_user)
    click_link 'ログアウト'
  end
  context 'レシピクリップできるとき' do
    it 'ログイン状態で、レシピ詳細画面でクリップボタンを押下するとクリップできる', js: true do
      # ログインする
      sign_in(@user)
      # 他ユーザーが投稿したレシピの詳細画面へ移動する
      expect(page).to have_content(@recipes_form.title)
      click_on @recipes_form.title
      # クリップボタンを押すとクリップモデルのカウントが上がることを確認する
      expect {
        find('div[id="clip_btn"]').click
        sleep 1.5
      }.to change { Clip.count }.by(1)
      # 自分のマイページに移動する
      visit user_path(@user.id)
      # クリップしたレシピがあることを確認する
      expect(page).to have_content(@recipes_form.title)
      # 他ユーザーが投稿したレシピの詳細画面へ移動する
      visit root_path
      expect(page).to have_content(@recipes_form.title)
      click_on @recipes_form.title
      # クリップ済みマークが表示されていることを確認する
      expect(page).to have_selector '.bi-star-fill'
    end
  end
  context 'レシピクリップできないとき' do
    it 'ログアウト状態ではクリップできない' do
      # トップページへ移動する
      visit root_path
      # 他ユーザーが投稿したレシピの詳細画面へ移動する
      expect(page).to have_content(@recipes_form.title)
      click_on @recipes_form.title
      # クリップボタンが表示されていないことを確認する
      expect(page).to have_no_selector 'div[id="clip_btn"]'
    end
    it '自分が投稿したレシピはクリップできない' do
      # ログインする
      sign_in(@user)
      # レシピを投稿する
      @user_recipes_form = recipe_post(@user)
      # 投稿したレシピの詳細画面へ移動する
      expect(page).to have_content(@user_recipes_form.title)
      click_on @user_recipes_form.title
      # クリップボタンが表示されていないことを確認する
      expect(page).to have_no_selector 'div[id="clip_btn"]'
    end
  end
end

RSpec.describe 'おすすめレシピ表示', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)

    sign_in(@another_user)
    @recipes_form = recipe_post(@another_user)
    profile_register(@another_user)
  end
  context 'おすすめレシピが表示されるとき' do
    it 'ログイン状態では、トップページに味の好みが同じユーザーが投稿したレシピを表示する' do
      # ログインする
      sign_in(@user)
      # プロフィール登録する
      profile_register(@user)
      # トップページへ移動する
      visit root_path
      # おすすめレシピが表示されていることを確認する
      expect(page).to have_content('が好きな人はこんなお料理を作っています')
      expect(page).to have_content(@recipes_form.title)
    end
  end
  context 'おすすめレシピが表示されないとき' do
    it 'ログイン状態でも、プロフィール登録がない場合はおすすめを表示しない' do
      # ログインする
      sign_in(@user)
      # トップページへ移動する
      visit root_path
      # おすすめレシピが表示されていないことを確認する
      expect(page).to have_no_content('が好きな人はこんなお料理を作っています')
    end
    it 'ログイン状態でも、味の好みが同じユーザーの投稿レシピがない場合はおすすめを表示しない' do
      # ログインする
      sign_in(@user)
      # another_userと異なる情報でプロフィール登録する
      visit new_user_profile_path(@user.id)
      select '女性', from: 'profile-gender'
      select '１人暮らし', from: 'profile-family-structure'
      select '辛いもの大好き', from: 'profile-taste'
      fill_in 'profiles_form_name', with: ''
      expect {
        find('input[name="commit"]').click
      }.to change { Profile.count }.by(1)
      expect(current_path).to eq(user_path(@user.id))
      # おすすめレシピが表示されていないことを確認する
      expect(page).to have_no_content('が好きな人はこんなお料理を作っています')
    end
    it 'ログアウト状態では、味の好みが同じユーザーのレシピは表示しない' do
      # トップページへ移動する
      visit root_path
      # おすすめレシピが表示されていないことを確認する
      expect(page).to have_no_content('が好きな人はこんなお料理を作っています')
    end
  end
end

RSpec.describe 'コメント投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)
    @recipes_form = recipe_post(@user)
  end
  context 'コメント投稿できるとき' do
    it 'ログイン状態では、レシピ詳細画面にコメント入力欄が表示されコメントを投稿できる' do
      # ログインする
      sign_in(@user)
      # レシピカードが表示されていることを確認する
      expect(page).to have_content(@recipes_form.title)
      # クリックしてレシピ詳細ページへ移動する
      click_on @recipes_form.title
      # コメント入力フォームが表示されていることを確認する
      expect(page).to have_selector 'textarea[id="comment_text"]'
      # コメントを入力する
      fill_in 'comment_text', with: '素敵'
      # 投稿ボタンを押下するとコメントモデルのカウントが上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(1)
      # 投稿したコメントが表示されていることを確認する
      expect(page).to have_content('素敵')
    end
  end
  context 'コメント投稿できないとき' do
    it 'ログアウト状態ではコメント投稿できない' do
      # トップページへ移動する
      visit root_path
      # レシピカードが表示されていることを確認する
      expect(page).to have_content(@recipes_form.title)
      # クリックしてレシピ詳細ページへ移動する
      click_on @recipes_form.title
      # コメント入力フォームが表示されていないことを確認する
      expect(page).to have_no_selector 'textarea[id="comment_text"]'
    end
  end
end
