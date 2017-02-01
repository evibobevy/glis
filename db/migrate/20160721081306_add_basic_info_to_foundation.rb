class AddBasicInfoToFoundation < ActiveRecord::Migration
  def change
    add_column :foundations, :basic_info, :text
  end
end
