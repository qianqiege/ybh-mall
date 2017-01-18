class ChangCountFromScoinType < ActiveRecord::Migration[5.0]
  def change
    change_column :scoin_types, :count, :decimal ,:precision => 10,:scale=>1
  end
end
