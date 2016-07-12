class AddImageFieldToFoundation < ActiveRecord::Migration
  def up
    add_attachment :foundations, :image
  end

  def down
    remove_attachment :foundations, :image
  end
end
