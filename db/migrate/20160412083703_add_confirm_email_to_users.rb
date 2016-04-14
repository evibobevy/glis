class AddConfirmEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirm_email, :string
  end
end
