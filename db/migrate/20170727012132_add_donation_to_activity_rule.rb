class AddDonationToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :donation, :decimal,:precision => 10,:scale=>2
  end
end
