class RemoveBooleanFromProduct < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :boolean, :string
  end
end
