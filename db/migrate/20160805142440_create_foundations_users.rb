class CreateFoundationsUsers < ActiveRecord::Migration
  def change
    create_table :foundations_users do |t|
      t.integer :foundation_id
      t.integer :user_id
    end
  end
end
