class AddParentIdToEmailMessages < ActiveRecord::Migration
  def change
    add_column :email_messages, :parent_id, :integer
  end
end
