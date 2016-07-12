class CreateFoundations < ActiveRecord::Migration
  def change
    create_table :foundations do |t|
      t.string :name
      t.string :city
      t.string :state
      t.text :description

      t.timestamps
    end
  end
end
