class RenameScoinTypeIdToCoinTypeIdOfActivityRules < ActiveRecord::Migration[5.0]
  def change
    rename_column(:activity_rules, :scoin_type_id, :coin_type_id)
  end
end
