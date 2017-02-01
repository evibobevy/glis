class ChnageRoleFieldNameToEvent < ActiveRecord::Migration
  def change
    rename_column :events, :role, :user_role
  end
end
