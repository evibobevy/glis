class AddFieldToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :everyone_view_profile, :boolean, :default => true
    add_column :foundations, :everyone_view_calendar, :boolean, :default => true
    add_column :foundations, :everyone_invite_you_to_events, :boolean, :default => true
    add_column :foundations, :everyone_view_posts, :boolean, :default => true
    add_column :foundations, :everyone_message_you, :boolean, :default => true
    add_column :foundations, :volunteers_need_approval_to_join_your_gigs, :boolean, :default => true
    add_column :foundations, :supporters_need_approval_to_comment_on_your_posts, :boolean, :default => true
  end
end
