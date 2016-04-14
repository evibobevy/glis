class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.string :name
      t.string :email
      t.string :company_name
      t.string :phone_number
      t.text :description

      t.timestamps
    end
  end
end
