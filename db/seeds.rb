# db/seeds.rb

begin
  user = User.create!(
    name: 'user_name',
    email: 'user@example.com',
    password: 'password',
    password_confirmation: 'password',
    admin: false
  )
  puts "User created successfully: #{user.email}"
rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create user: #{e.record.errors.full_messages.join(', ')}"
end

begin
  admin = User.create!(
    name: 'admin_name',
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    admin: true
  )
  puts "Admin created successfully: #{admin.email}"
rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create admin: #{e.record.errors.full_messages.join(', ')}"
end
