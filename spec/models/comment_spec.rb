require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント機能' do
    context 'コメント投稿できるとき' do
      it 'text,user,recipeがあれば登録できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメント投稿できないとき' do
      it 'textがないと登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントを入力してください')
      end

      it 'userがないと登録できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'recipeがないと登録できない' do
        @comment.recipe = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('レシピを入力してください')
      end
    end
  end
end
