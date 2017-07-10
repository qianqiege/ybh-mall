class AddSpecToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :spec, :string
  end
end
