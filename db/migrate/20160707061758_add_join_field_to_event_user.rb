class AddJoinFieldToEventUser < ActiveRecord::Migration
  def change
    add_column :events_users, :join_event, :boolean, :default => false
  end
end
