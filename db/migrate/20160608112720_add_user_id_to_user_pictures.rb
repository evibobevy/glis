class AddUserIdToUserPictures < ActiveRecord::Migration
  def change
    add_column :user_pictures, :user_id, :int
  end
end
