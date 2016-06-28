class RemoveColumnInUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :everyone_view_calendar
    remove_column :users, :everyone_invite_you_to_events
    remove_column :users, :everyone_view_your_post
    remove_column :users, :everyone_message_you
    remove_column :users, :volunteers_need_approval_join_your_gigs
    remove_column :users, :supporters_need_approval_to_comment
  end
end
