require 'rails_helper'

RSpec.describe '対応者管理機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:label1) { FactoryBot.create(:label, name: '対応者1', user: user) }
  let!(:label2) { FactoryBot.create(:label, name: '対応者2', user: user) }

  before do
    # ログイン処理
    visit new_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '登録機能' do
    context '対応者を登録した場合' do
      it '登録した対応者が表示される' do
        visit new_label_path
        fill_in '名前', with: '新しい対応者'
        click_button '登録する'
        expect(page).to have_content '新しい対応者'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '登録済みの対応者一覧が表示される' do
        visit labels_path
        expect(page).to have_content '対応者1'
        expect(page).to have_content '対応者2'
      end
    end
  end
end
