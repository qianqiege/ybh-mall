class RenameScoinTypeOfActivityRules < ActiveRecord::Migration[5.0]
  def change
    remove_column :activity_rules, :scoin_type
    add_column :activity_rules, :scoin_type_id, :integer
  end
end
