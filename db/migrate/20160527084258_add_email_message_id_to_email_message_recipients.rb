class AddEmailMessageIdToEmailMessageRecipients < ActiveRecord::Migration
  def change
    add_column :email_message_recipients, :email_message_id, :integer
  end
end
