class CreateWarehouses < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.integer :organization_id
      t.integer :up_id
      t.string :address

      t.timestamps
    end
  end
end
