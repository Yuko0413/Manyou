require 'rails_helper'

RSpec.describe 'ユーザモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { User.new(name: name, email: email, password: password) }

    context 'ユーザの名前が空文字の場合' do
      let(:name) { '' }
      let(:email) { 'test@example.com' }
      let(:password) { 'password' }

      it 'バリデーションに失敗する' do
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスが空文字の場合' do
      let(:name) { 'Test User' }
      let(:email) { '' }
      let(:password) { 'password' }

      it 'バリデーションに失敗する' do
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが空文字の場合' do
      let(:name) { 'Test User' }
      let(:email) { 'test@example.com' }
      let(:password) { '' }

      it 'バリデーションに失敗する' do
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスがすでに使用されていた場合' do
      let(:name) { 'Test User' }
      let(:email) { 'test@example.com' }
      let(:password) { 'password' }

      before { create(:user, email: email) }

      it 'バリデーションに失敗する' do
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが6文字未満の場合' do
      let(:name) { 'Test User' }
      let(:email) { 'test@example.com' }
      let(:password) { 'short' }

      it 'バリデーションに失敗する' do
        expect(user).not_to be_valid
      end
    end

    context 'ユーザの名前に値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上の場合' do
      let(:name) { 'Test User' }
      let(:email) { 'unique@example.com' }
      let(:password) { 'password' }

      it 'バリデーションに成功する' do
        expect(user).to be_valid
      end
    end
  end
end
