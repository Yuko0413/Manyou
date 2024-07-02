class User < ApplicationRecord  

  has_secure_password
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  before_validation { email.downcase! }
  validates :admin, inclusion: { in: [true, false] }

  before_destroy :ensure_an_admin_remains
  before_update :ensure_an_admin_remains_on_update

  def translated_priority(priority)
    case priority
    when 'low'
      '低'
    when 'medium'
      '中'
    when 'high'
      '高'
    else
      priority
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def ensure_an_admin_remains
    if User.where(admin: true).count == 1 && self.admin?
      errors.add(:base, '管理者が0人になるため削除できません')
      throw :abort
    end
  end

  def ensure_an_admin_remains_on_update
    if User.where(admin: true).count == 1 && self.admin? && !self.admin
      errors.add(:base, '管理者が0人になるため権限を変更できません')
      throw :abort
    end

    # `admin` フラグが変更された場合の条件を追加
    if self.admin_changed? && self.admin_was && !self.admin
      if User.where(admin: true).count == 1
        errors.add(:base, '管理者が0人になるため権限を変更できません')
        throw :abort
      end
    end
  end
end
