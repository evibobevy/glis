class AddImageToFoundationPicture < ActiveRecord::Migration
  def up
    add_attachment :foundation_pictures, :image
  end

  def down
    remove_attachment :foundation_pictures, :image
  end
end
