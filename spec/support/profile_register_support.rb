module ProfileRegisterSupport
  def profile_register(user)
    visit new_user_profile_path(user.id)

    select '女性', from: 'profile-gender'
    select '１人暮らし', from: 'profile-family-structure'
    select '薄味が好き', from: 'profile-taste'
    fill_in 'profiles_form_name', with: ''
    expect {
      find('input[name="commit"]').click
    }.to change { Profile.count }.by(1)

    expect(current_path).to eq(user_path(user.id))
  end
end
