class RemoveRoleFiledToEventUser < ActiveRecord::Migration
  def change
    remove_column :events_users, :role, :integer
  end
end
