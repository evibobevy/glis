class CreateFoundationFriendships < ActiveRecord::Migration
  def change
    create_table :foundation_friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
