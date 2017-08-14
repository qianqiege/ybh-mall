class AddIsDonationToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :is_donation, :boolean
  end
end
