class AddNotificationFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_notification, :boolean, default: true
    add_column :users, :sms_notification, :boolean, default: true
  end
end
