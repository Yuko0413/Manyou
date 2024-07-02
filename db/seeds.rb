# Task.create!(
#   [
#     { title: 'Task 1', content: 'Content for task 1', deadline_on: Date.today + 1.day, priority: 'high', status: 'not_started' },
#     { title: 'Task 2', content: 'Content for task 2', deadline_on: Date.today + 2.days, priority: 'medium', status: 'in_progress' },
#     { title: 'Task 3', content: 'Content for task 3', deadline_on: Date.today + 3.days, priority: 'low', status: 'completed' },
#     { title: 'Task 4', content: 'Content for task 4', deadline_on: Date.today + 4.days, priority: 'high', status: 'not_started' },
#     { title: 'Task 5', content: 'Content for task 5', deadline_on: Date.today + 5.days, priority: 'medium', status: 'in_progress' },
#     { title: 'Task 6', content: 'Content for task 6', deadline_on: Date.today + 6.days, priority: 'low', status: 'completed' },
#     { title: 'Task 7', content: 'Content for task 7', deadline_on: Date.today + 7.days, priority: 'high', status: 'not_started' },
#     { title: 'Task 8', content: 'Content for task 8', deadline_on: Date.today + 8.days, priority: 'medium', status: 'in_progress' },
#     { title: 'Task 9', content: 'Content for task 9', deadline_on: Date.today + 9.days, priority: 'low', status: 'completed' },
#     { title: 'Task 10', content: 'Content for task 10', deadline_on: Date.today + 10.days, priority: 'high', status: 'not_started' }
#   ]
# )

# db/seeds.rb

# ユーザの作成
user = User.create!(
  name: 'user_name',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

admin = User.create!(
  name: 'admin_name',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

# タスクの作成
50.times do |i|
  Task.create!(
    title: "task_title_#{i}",
    content: "task_content_#{i}",
    deadline_on: Time.now + (i + 1).days,
    priority: [:low, :medium, :high].sample,
    status: [:not_started, :in_progress, :completed].sample,
    user: user
  )
end

50.times do |i|
  Task.create!(
    title: "task_title_#{i + 50}",
    content: "task_content_#{i + 50}",
    deadline_on: Time.now + (i + 1).days,
    priority: [:low, :medium, :high].sample,
    status: [:not_started, :in_progress, :completed].sample,
    user: admin
  )
end

