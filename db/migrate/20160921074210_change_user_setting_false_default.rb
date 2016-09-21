class ChangeUserSettingFalseDefault < ActiveRecord::Migration
  def change
    change_column :users, :everyone_view_your_profile, :boolean, :default => true
    change_column :users, :everyone_view_your_calendar, :boolean, :default => true
    change_column :users, :everyone_invite_you_to_events, :boolean, :default => true
    change_column :users, :everyone_view_your_post, :boolean, :default => true
    change_column :users, :everyone_message_you, :boolean, :default => true
    change_column :users, :volunteers_need_approval_join_your_gigs, :boolean, :default => true
    change_column :users, :supporters_need_approval_to_comment, :boolean, :default => false
    change_column :users, :email_notification, :boolean, :default => true
    change_column :users, :sms_notification, :boolean, :default => true
    change_column :users, :mobile_ping_notifications, :boolean, :default => true
  end
end
