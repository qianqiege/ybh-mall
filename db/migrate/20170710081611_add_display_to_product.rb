class AddDisplayToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :display, :boolean
  end
end
