class AddTypeOfFoundationToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :type_of_foundation, :integer
    add_column :foundations, :user_role, :integer
  end
end
