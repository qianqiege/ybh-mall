class CreateShoppings < ActiveRecord::Migration[5.0]
  def change
    create_table :shoppings do |t|
      t.integer :number
      t.string :name
      t.float :maney

      t.timestamps
    end
  end
end
