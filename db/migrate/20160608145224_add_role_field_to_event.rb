class AddRoleFieldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :role, :integer
  end
end
