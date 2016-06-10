class AddTypeOfGigFieldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :type_of_gig, :integer
  end
end
