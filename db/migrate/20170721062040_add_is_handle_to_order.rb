class AddIsHandleToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :is_handle, :boolean
  end
end
