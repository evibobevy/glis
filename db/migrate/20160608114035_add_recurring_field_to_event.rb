class AddRecurringFieldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :recurring, :boolean, :default => true
    add_column :events, :open_to_the_public, :boolean, :default => true
    add_column :events, :anyone_volunteer, :boolean, :default => true
  end
end
