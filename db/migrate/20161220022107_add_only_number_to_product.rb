class AddOnlyNumberToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :only_number, :string
  end
end
