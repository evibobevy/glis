class AddFoundationIdToFoundationPicture < ActiveRecord::Migration
  def change
    add_column :foundation_pictures, :foundation_id, :integer
  end
end
