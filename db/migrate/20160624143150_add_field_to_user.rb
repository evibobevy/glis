class AddFieldToUser < ActiveRecord::Migration
  def self.up
    change_column :users, :volunteers_need_approval_join_your_gigs, 'boolean USING CAST(volunteers_need_approval_join_your_gigs AS boolean)'
  end
end
