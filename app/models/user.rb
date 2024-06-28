class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  #validates :password_confirmation, presence: true, on: :create
  validates :admin, inclusion: { in: [true, false] }
end
