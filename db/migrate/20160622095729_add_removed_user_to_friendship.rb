class AddRemovedUserToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :removed_user, :boolean, :default => false
  end
end
