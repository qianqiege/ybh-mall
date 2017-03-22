class AddPriorityToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :priority, :integer, default: 0
  end
end
