class AddFoundationNameToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :foundation_name, :string
  end
end
