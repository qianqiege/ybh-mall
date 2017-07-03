class AddYbzNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ybz_number, :integer
  end
end
