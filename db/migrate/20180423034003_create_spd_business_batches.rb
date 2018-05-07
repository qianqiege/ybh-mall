class CreateSpdBusinessBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :spd_business_batches do |t|
      t.integer :spd_business_item_id
      t.string :batch
      t.datetime :date
      t.string :count
      t.string :receive_count

      t.timestamps
    end
  end
end
