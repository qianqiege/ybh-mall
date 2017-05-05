class AddPercentageToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :percentage, :float
  end
end
