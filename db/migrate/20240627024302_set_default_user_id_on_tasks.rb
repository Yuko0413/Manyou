class SetDefaultUserIdOnTasks < ActiveRecord::Migration[6.1]
  def up
    # デフォルトのユーザーを作成または取得
    default_user = User.find_or_create_by!(email: 'default@example.com') do |user|
      user.name = 'Default User'
      user.password = 'password'
      user.password_confirmation = 'password'
      user.admin = false
    end

    # 既存のタスクにデフォルトユーザーを設定
    Task.where(user_id: nil).update_all(user_id: default_user.id)

    # `user_id` カラムに `null` 制約を追加
    change_column_null :tasks, :user_id, false
  end

  def down
    change_column_null :tasks, :user_id, true

    # デフォルトユーザーを削除（必要に応じて）
    default_user = User.find_by(email: 'default@example.com')
    Task.where(user_id: default_user.id).update_all(user_id: nil)
  end
end
