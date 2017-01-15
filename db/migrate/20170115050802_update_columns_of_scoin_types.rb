class UpdateColumnsOfScoinTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_types, :remain_count, :decimal
    add_column :scoin_types, :present_count, :decimal
    remove_column :scoin_types, :limit_count, :decimal
  end
end
