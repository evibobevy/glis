class CreateEmailMessageRecipients < ActiveRecord::Migration
  def change
    create_table :email_message_recipients do |t|
      t.string :email

      t.timestamps
    end
  end
end
