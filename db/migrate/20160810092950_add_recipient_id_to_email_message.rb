class AddRecipientIdToEmailMessage < ActiveRecord::Migration
  def change
    add_column :email_messages, :recipient_id, :integer
  end
end
