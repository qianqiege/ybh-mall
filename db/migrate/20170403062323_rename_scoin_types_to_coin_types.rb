class RenameScoinTypesToCoinTypes < ActiveRecord::Migration[5.0]
  def change
    rename_table :scoin_types, :coin_types
  end
end
