class RemoveColumnInUser < ActiveRecord::Migration
  def change
    remove_column :users, :everyone_view_profile
  end
end
