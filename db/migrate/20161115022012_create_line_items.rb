class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.belongs_to :product
      t.belongs_to :cart
      t.integer :quantity, default: 1
    end
  end
end
