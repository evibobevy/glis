class AddDateFieldToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :start_date, :datetime
    add_column :foundations, :end_date, :datetime
  end
end
