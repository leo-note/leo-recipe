require 'rails_helper'

RSpec.describe Follow, type: :model do
  before do
    followee = FactoryBot.create(:user)
    follower = FactoryBot.create(:user)
    @follow = FactoryBot.build(:follow, followee_id: followee.id, follower_id: follower.id)
  end

  describe 'ユーザーフォロー' do
    context 'フォローできるとき' do
      it 'followee_id,follower_idがあれば登録できる' do
        expect(@follow).to be_valid
      end
    end

    context 'フォローできないとき' do
      it 'followee_idがないと登録できない' do
        @follow.followee_id = nil
        @follow.valid?
        expect(@follow.errors.full_messages).to include('フォロイーを入力してください')
      end

      it 'follower_idがないと登録できない' do
        @follow.follower_id = nil
        @follow.valid?
        expect(@follow.errors.full_messages).to include('フォロワーを入力してください')
      end
    end
  end
end
