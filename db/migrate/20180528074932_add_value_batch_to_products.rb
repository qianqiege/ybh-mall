class AddValueBatchToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :value_batch, :string
  end
end
