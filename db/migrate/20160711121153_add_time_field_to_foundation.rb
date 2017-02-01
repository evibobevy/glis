class AddTimeFieldToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :start_time, :time
    add_column :foundations, :end_time, :time
  end
end
