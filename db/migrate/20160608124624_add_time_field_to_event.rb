class AddTimeFieldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_start_time, :time
    add_column :events, :event_end_time, :time
  end
end
