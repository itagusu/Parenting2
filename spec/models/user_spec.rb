require 'rails_helper'

RSpec.describe 'User', type: :model do
  before do
    @user = build(:user)
  end
  describe 'バリデーションのテスト' do
    describe 'last_nameカラム' do
      it 'last_name空欄NG' do
        @user.last_name = ''
        expect(@user.valid?).to eq(false)
      end
    end

    describe 'first_nameカラム' do
      it 'first_name空欄NG' do
        @user.first_name = ''
        expect(@user.valid?).to eq(false)
      end
    end

    describe 'emailカラム' do
      it 'email空欄NG' do
        @user.email = ''
        expect(@user.valid?).to eq(false)
      end
    end
    context 'introductionカラム' do
      it '100文字以下であること: 100文字はOK' do
        @user.introduction = Faker::Lorem.characters(number: 100)
        expect(@user.valid?).to eq(false)
      end
      it '100文字以下であること: 101文字はNG' do
        @user.introduction = Faker::Lorem.characters(number: 101)
        expect(@user.valid?).to eq(false)
      end
    end
  end
end