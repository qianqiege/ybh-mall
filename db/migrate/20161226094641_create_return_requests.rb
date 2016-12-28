class CreateReturnRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :return_requests do |t|
      t.belongs_to :line_item
      t.belongs_to :order
      t.integer :quantity, default: 1
      t.text :desc
      t.integer :tp, default: 0

      t.timestamps
    end
  end
end
