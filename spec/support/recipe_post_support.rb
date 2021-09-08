module RecipePostSupport
  def recipe_post(user)
    recipes_form = FactoryBot.build(:recipes_form, user_id: user.id)

    expect(page).to have_content('レシピ投稿')
    visit new_recipe_path

    fill_in 'recipe_title', with: recipes_form.title
    attach_file 'recipe_image', "#{Rails.root}/public/images/test_image.jpg"
    select '和食', from: 'recipe-category'
    fill_in 'material_name_1', with: recipes_form.names[0]
    fill_in 'recipe_amount_1', with: recipes_form.amounts[0]
    fill_in 'material_name_2', with: recipes_form.names[1]
    fill_in 'recipe_amount_2', with: recipes_form.amounts[1]
    fill_in 'material_name_3', with: recipes_form.names[2]
    fill_in 'recipe_amount_3', with: recipes_form.amounts[2]
    fill_in 'recipe_text', with: recipes_form.text

    expect {
      find('input[name="commit"]').click
    }.to change { Recipe.count }.by(1)

    expect(current_path).to eq(root_path)

    return recipes_form
  end
end
