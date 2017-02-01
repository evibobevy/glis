class ChnageTypeDataUser < ActiveRecord::Migration
  def up
    change_column :users, :volunteers_need_approval_join_your_gigs, :boolean, :default => true
  end

  def down
    change_column :users, :volunteers_need_approval_join_your_gigs, :boolean, :default => nil
  end
end
