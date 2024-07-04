FactoryBot.define do
  factory :user do
    name { 'user_name' }
    email { 'user@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }

    trait :admin do
      name { 'admin_name' }
      email { 'admin@example.com' }
      admin { true }
    end
  end
end
