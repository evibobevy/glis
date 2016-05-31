class CreateEmailMessages < ActiveRecord::Migration
  def change
    create_table :email_messages do |t|
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
