require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '検索機能' do
    let!(:task1) { create(:task, title: 'first_task', deadline_on: '2022-02-18', priority: 'medium', status: 'not_started') }
    let!(:task2) { create(:task, title: 'second_task', deadline_on: '2022-02-17', priority: 'high', status: 'in_progress') }
    let!(:task3) { create(:task, title: 'third_task', deadline_on: '2022-02-16', priority: 'low', status: 'completed') }

    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索ワードを含むタスクが絞り込まれる' do
        expect(Task.with_title('task')).to include(task1, task2, task3)
        expect(Task.with_title('task').count).to eq 3
        expect(Task.with_title('first')).to include(task1)
        expect(Task.with_title('first')).not_to include(task2, task3)
        expect(Task.with_title('first').count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.with_status('not_started')).to include(task1)
        expect(Task.with_status('not_started')).not_to include(task2, task3)
        expect(Task.with_status('not_started').count).to eq 1

        expect(Task.with_status('in_progress')).to include(task2)
        expect(Task.with_status('in_progress')).not_to include(task1, task3)
        expect(Task.with_status('in_progress').count).to eq 1

        expect(Task.with_status('completed')).to include(task3)
        expect(Task.with_status('completed')).not_to include(task1, task2)
        expect(Task.with_status('completed').count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索ワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.with_title('task').with_status('not_started')).to include(task1)
        expect(Task.with_title('task').with_status('not_started')).not_to include(task2, task3)
        expect(Task.with_title('task').with_status('not_started').count).to eq 1

        expect(Task.with_title('task').with_status('in_progress')).to include(task2)
        expect(Task.with_title('task').with_status('in_progress')).not_to include(task1, task3)
        expect(Task.with_title('task').with_status('in_progress').count).to eq 1

        expect(Task.with_title('task').with_status('completed')).to include(task3)
        expect(Task.with_title('task').with_status('completed')).not_to include(task1, task2)
        expect(Task.with_title('task').with_status('completed').count).to eq 1
      end
    end
  end
end
