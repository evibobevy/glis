class AddFromUserIdToEmailMessage < ActiveRecord::Migration
  def change
    add_column :email_messages, :from_user_id, :integer
  end
end