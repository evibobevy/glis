class ChangeFieldNameToUser < ActiveRecord::Migration
  def change
    rename_column :users, :user_profile_settings, :everyone_view_profile
    rename_column :users, :user_post_comments_settings, :everyone_view_calendar
    rename_column :users, :user_message_settings, :everyone_invite_you_to_events
    rename_column :users, :user_events_invite_settings, :everyone_view_your_post
    add_column :users, :everyone_message_you, :integer
    add_column :users, :volunteers_need_approval_join_your_gigs, :integer
    add_column :users, :supporters_need_approval_to_comment , :integer
  end
end
