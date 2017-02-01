class AddRoleFieldToEventsUsers < ActiveRecord::Migration
  def change
    add_column :events_users, :role, :integer
  end
end
