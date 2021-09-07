# ユーザー
testuser1 = User.create(nickname: 'testuser1', email:'user1@test.com', password:'testuser1', password_confirmation:'testuser1')
testuser2 = User.create(nickname: 'testuser2', email:'user2@test.com', password:'testuser2', password_confirmation:'testuser2')
testuser3 = User.create(nickname: 'testuser3', email:'user3@test.com', password:'testuser3', password_confirmation:'testuser3')
testuser4 = User.create(nickname: 'testuser4', email:'user4@test.com', password:'testuser4', password_confirmation:'testuser4')
testuser5 = User.create(nickname: 'testuser5', email:'user5@test.com', password:'testuser5', password_confirmation:'testuser5')

# プロフイール
user1_profile = ProfilesForm.new(user_id: testuser1.id, gender_id: 2, family_structure_id: 2, taste_id: 3, name: 'エビ')
user1_profile.save
user2_profile = ProfilesForm.new(user_id: testuser2.id, gender_id: 3, family_structure_id: 4, taste_id: 5, name: '')
user2_profile.save
user3_profile = ProfilesForm.new(user_id: testuser3.id, gender_id: 2, family_structure_id: 3, taste_id: 2, name: '')
user3_profile.save
user4_profile = ProfilesForm.new(user_id: testuser4.id, gender_id: 4, family_structure_id: 5, taste_id: 4, name: '')
user4_profile.save
user5_profile = ProfilesForm.new(user_id: testuser5.id, gender_id: 2, family_structure_id: 2, taste_id: 3, name: '')
user5_profile.save