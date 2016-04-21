class AddStartDateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :datetime
  end
end
