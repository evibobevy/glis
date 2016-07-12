class AddUserIdToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :user_id, :integer
  end
end
