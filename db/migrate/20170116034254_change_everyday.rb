class ChangeEveryday < ActiveRecord::Migration[5.0]
  def change
    change_column :scoin_types, :everyday, :decimal ,:precision => 10,:scale=>1
    change_column :scoin_types, :once, :integer
  end
end
