class AddAcceptedToFoundationFriendship < ActiveRecord::Migration
  def change
    add_column :foundation_friendships, :accepted, :string
  end
end
