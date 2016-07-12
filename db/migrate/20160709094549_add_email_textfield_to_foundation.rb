class AddEmailTextfieldToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :email_notifications, :boolean, :default => true
    add_column :foundations, :text_notifications, :boolean, :default => true
  end
end
