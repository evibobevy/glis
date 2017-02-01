class ChangeDataTypeToComment < ActiveRecord::Migration
  def up
    change_column :comments, :commenter, :text
  end

  def down
    change_column :comments, :commenter, :string
  end
end
