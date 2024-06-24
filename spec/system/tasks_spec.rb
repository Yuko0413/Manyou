require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do

        # テストデータの作成
        let!(:task1) { Task.create!(title: 'first_task', content: 'First Content', created_at: '2022-02-18') }
        let!(:task2) { Task.create!(title: 'second_task', content: 'Second Content', created_at: '2022-02-17') }
        let!(:task3) { Task.create!(title: 'third_task', content: 'Third Content', created_at: '2022-02-16') }
        
        before do
          visit tasks_path
        end

        context '複数のタスクが存在する場合' do
          it '作成日時の降順で表示される' do

        # タスクの順序を確認
        tasks = all('tbody tr')

        expect(tasks[0]).to have_content 'first_task'
        expect(tasks[1]).to have_content 'second_task'
        expect(tasks[2]).to have_content 'third_task'
      end
    end

    context '新たにタスクを作成した場合' do
      before do
        visit new_task_path
        fill_in 'タイトル', with: 'New Task'
        fill_in '内容', with: 'New Content'
        click_button '登録する'
        visit tasks_path
      end

      it '新しいタスクが一番上に表示される' do

        tasks = all('tbody tr')

        expect(tasks[0]).to have_content 'New Task'
        expect(tasks[1]).to have_content 'first_task'
        expect(tasks[2]).to have_content 'second_task'

      end
    end
  end
end