class AddSettingFieldToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :recurring, :boolean, :default => true
    add_column :foundations, :open_to_the_public, :boolean, :default => true
    add_column :foundations, :anyone_volunteer, :boolean, :default => true
  end
end
