require 'rails_helper'

RSpec.describe 'Post', type: :model do
  before do
    @post = build(:post)
  end

  context 'bodyカラム' do
    it '200文字以下であること: 200文字はOK' do
      @post.body = Faker::Lorem.characters(number: 200)
      expect(@post.valid?).to eq(false)
    end
    it '200文字以下であること: 201文字はNG' do
      @user.body = Faker::Lorem.characters(number: 201)
      expect(@post.valid?).to eq(false)
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
