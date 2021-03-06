require 'rails_helper'

RSpec.describe Clip, type: :model do
  before do
    @clip = FactoryBot.build(:clip)
  end

  describe 'clip' do
    context 'clipできるとき' do
      it 'user,recipeがあれば登録できる' do
        expect(@clip).to be_valid
      end
    end

    context 'clipできないとき' do
      it 'userがないと登録できない' do
        @clip.user = nil
        @clip.valid?
        expect(@clip.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'recipeがないと登録できない' do
        @clip.recipe = nil
        @clip.valid?
        expect(@clip.errors.full_messages).to include('レシピを入力してください')
      end
    end
  end
end
