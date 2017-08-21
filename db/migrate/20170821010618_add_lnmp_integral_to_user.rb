class AddLnmpIntegralToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lnmp_integral, :decimal,:precision => 10,:scale=>2
  end
end
