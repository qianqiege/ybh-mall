class AddIsYbzToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :is_ybz, :integer
  end
end
