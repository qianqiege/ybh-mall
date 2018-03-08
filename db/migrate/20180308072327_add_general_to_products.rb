class AddGeneralToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :general, :string
  end
end
