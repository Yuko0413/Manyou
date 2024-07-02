class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy


  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  #validates :password_confirmation, presence: true, on: :create
  validates :admin, inclusion: { in: [true, false] }

  before_destroy :ensure_an_admin_remains
  before_update :ensure_an_admin_remains_on_update

  private

  def ensure_an_admin_remains
    if User.where(admin: true).count == 1 && self.admin?
      errors.add(:base, '管理者が0人になるため削除できません')
      throw :abort
    end
  end

  def ensure_an_admin_remains_on_update
    if User.where(admin: true).count == 1 && self.admin? && self.admin_changed?(from: true, to: false)
      errors.add(:base, '管理者が0人になるため権限を変更できません')
      throw :abort
    end
  end
end
