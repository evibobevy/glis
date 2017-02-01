class AddFoundationNameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :foundation_name, :integer
  end
end
