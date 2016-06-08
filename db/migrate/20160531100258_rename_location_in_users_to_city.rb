class RenameLocationInUsersToCity < ActiveRecord::Migration
  def change
    rename_column :users, :location, :city
  end
end
