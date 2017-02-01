class AddPrivacySettingToUser < ActiveRecord::Migration
  def change
    add_column :users, :everyone_view_your_profile, :boolean, default: true
    add_column :users, :everyone_view_your_calendar, :boolean, default: true
    add_column :users, :everyone_invite_you_to_events, :boolean, default: true
    add_column :users, :everyone_view_your_post, :boolean, default: true
    add_column :users, :everyone_message_you, :boolean, default: true
    add_column :users, :volunteers_need_approval_join_your_gigs, :boolean, default: true
    add_column :users, :supporters_need_approval_to_comment, :boolean, default: true
  end
end
