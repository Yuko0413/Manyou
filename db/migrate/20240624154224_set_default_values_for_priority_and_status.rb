class SetDefaultValuesForPriorityAndStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :priority, from: nil, to: 0
    change_column_default :tasks, :status, from: nil, to: 0

    reversible do |dir|
      dir.up do
        Task.where(priority: nil).update_all(priority: 0)
        Task.where(status: nil).update_all(status: 0)
      end
    end
  end
end
