# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Task.delete_all

# 50件のタスクデータを作成
50.times do |i|
  Task.create!(
    title: "Task #{i + 1}",
    content: "This is the content for task #{i + 1}",
    created_at: Time.now - rand(1..100).days # 過去100日間のランダムな作成日時
  )
end

puts "50件のタスクデータを作成しました。"
