class AddDataNumberToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :data_number, :float
  end
end
