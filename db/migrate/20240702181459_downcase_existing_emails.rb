class DowncaseExistingEmails < ActiveRecord::Migration[6.1]
  def up
    User.all.each do |user|
      user.update_column(:email, user.email.downcase)
    end
  end

  def down
    # 逆の操作は定義しません
  end
end
