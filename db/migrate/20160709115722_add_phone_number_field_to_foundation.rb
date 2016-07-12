class AddPhoneNumberFieldToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :mobile_ping_notifications, :boolean, :default => true
    add_column :foundations, :phone_number, :string
  end
end
