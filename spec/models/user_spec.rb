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

    describe 'アソシエーションのテスト' do
      context 'Postモデルとの関係' do
        it '1:Nとなっている' do
          expect(User.reflect_on_association(:posts).macro).to eq :has_many
        end
      end
    end
    describe 'テスト' do
      let(:user) { create(:user) }
      let!(:other_user) { create(:user) }
      let!(:post) { create(:post, user: user) }
      let!(:other_post) { create(:post, user: other_user) }

      describe 'サクセスメッセージのテスト' do
        subject { page }

        it 'ユーザ新規登録成功時' do
          visit new_user_registration_path
          fill_in 'user[email]', with: 'a' + user.email # 確実にuser, other_userと違う文字列にするため
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button 'Sign up'
          is_expected.to have_content 'successfully'
        end
      end
    end
  end
end