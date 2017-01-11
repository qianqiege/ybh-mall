class CreateScoinRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :scoin_records do |t|
      t.integer :number
      t.string :state
      t.integer :scoin_account_id
      t.timestamps
    end
  end
end
