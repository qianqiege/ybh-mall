class AddIsTestToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :is_test, :boolean,  default: false
  end
end
