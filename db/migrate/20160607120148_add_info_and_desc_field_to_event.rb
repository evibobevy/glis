class AddInfoAndDescFieldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :basic_info, :text
    add_column :events, :full_description, :text
  end
end
