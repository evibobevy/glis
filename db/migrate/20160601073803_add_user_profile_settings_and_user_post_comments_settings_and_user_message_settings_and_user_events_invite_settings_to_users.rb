class AddUserProfileSettingsAndUserPostCommentsSettingsAndUserMessageSettingsAndUserEventsInviteSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_profile_settings, :int, :limit => 2, :default => 0
    add_column :users, :user_post_comments_settings, :int, :limit => 2, :default => 0
    add_column :users, :user_message_settings, :int, :limit => 2, :default => 0
    add_column :users, :user_events_invite_settings, :int, :limit => 2, :default => 0
  end
end
