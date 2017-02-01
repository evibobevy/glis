class ChangeDataTypeFoundationName < ActiveRecord::Migration
  def up
    change_column :events, :foundation_name, :string
  end

  def down
    change_column :events, :foundation_name, :integer
  end
end
