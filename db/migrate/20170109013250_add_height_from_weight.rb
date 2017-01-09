class AddHeightFromWeight < ActiveRecord::Migration[5.0]
  def change
    add_column :weights, :height, :string
  end
end
