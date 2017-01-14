class AddLimitCountToScoinTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_types, :limit_count, :decimal
  end
end
