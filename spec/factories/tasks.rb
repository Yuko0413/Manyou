FactoryBot.define do
  factory :task do
    title { 'テストタイトル' }
    content { 'テスト内容' }
    deadline_on { Date.today }
    priority { 'low' }
    status { 'not_started' }
  end
end
