class AddMobilePingNotificationFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile_ping_notifications, :boolean, default: true
  end
end
