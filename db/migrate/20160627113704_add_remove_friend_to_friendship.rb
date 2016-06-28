class AddRemoveFriendToFriendship < ActiveRecord::Migration
  def change
      add_column :friendships, :removed_friend, :boolean, :default => false
  end
end
