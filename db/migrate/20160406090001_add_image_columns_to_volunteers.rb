class AddImageColumnsToVolunteers < ActiveRecord::Migration
  def up
    add_attachment :volunteers, :image
  end

  def down
    remove_attachment :volunteers, :image
  end
end
