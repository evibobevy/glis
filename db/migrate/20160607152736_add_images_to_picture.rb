class AddImagesToPicture < ActiveRecord::Migration
  def change
    add_attachment :pictures, :image
    add_column :pictures, :event_id, :integer
  end
end
