require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin) { FactoryBot.create(:user, :admin) }

  def login_as(user)
    visit new_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '登録機能' do
    context 'ユーザを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in '名前', with: 'test_user'
        fill_in 'メールアドレス', with: 'test_user@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'タスク一覧'
      end
    end

    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe 'ログイン機能' do
    context '登録済みのユーザでログインした場合' do
      before do
        login_as(user)
      end

      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content 'ログインしました'
      end

      it '自分の詳細画面にアクセスできる' do
        visit user_path(user)
        expect(page).to have_content 'ユーザ詳細'
        expect(page).to have_content user.name
      end

      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        visit user_path(admin)
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content 'アクセス権限がありません'
      end

      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理者機能' do
    context '管理者がログインした場合' do
      before do
        login_as(admin)
      end

      it 'ユーザ一覧画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content 'ユーザ一覧'
      end

      it '管理者を登録できる' do
        visit new_admin_user_path
        fill_in '名前', with: 'new_admin'
        fill_in 'メールアドレス', with: 'new_admin@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        check '管理者権限'
        click_button '登録する'
        expect(page).to have_content 'ユーザを登録しました'
        expect(User.last.admin?).to be true
      end

      it 'ユーザ詳細画面にアクセスできる' do
        visit admin_user_path(user)
        expect(page).to have_content 'ユーザ詳細'
        expect(page).to have_content user.name
      end

      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        visit edit_admin_user_path(user)
        fill_in '名前', with: 'updated_user'
        click_button '更新する'
        expect(page).to have_content 'ユーザを更新しました'
        expect(user.reload.name).to eq 'updated_user'
      end

      it 'ユーザを削除できる' do
        visit admin_users_path
        find(".delete-user[data-id='#{user.id}']").click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザを削除しました'
        expect(User.exists?(user.id)).to be false
      end
    end

    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      before do
        login_as(user)
      end

      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '管理者以外アクセスできません'
      end
    end
  end
end
