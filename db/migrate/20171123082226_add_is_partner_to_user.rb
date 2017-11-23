class AddIsPartnerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_partner, :boolean
  end
end
