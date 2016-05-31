class ChangeFieldNameToEmailMessage < ActiveRecord::Migration
  def change
    rename_column :email_messages, :from_user_id, :user_id
  end
end
