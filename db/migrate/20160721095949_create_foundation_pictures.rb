class CreateFoundationPictures < ActiveRecord::Migration
  def change
    create_table :foundation_pictures do |t|

      t.timestamps
    end
  end
end
