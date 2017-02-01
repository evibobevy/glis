class AddAcceptedFieldToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :accepted, :string
  end
end
