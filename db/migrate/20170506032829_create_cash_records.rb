class CreateCashRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :cash_records do |t|
      t.decimal :number
      t.string :reason
      t.boolean :is_effective
      t.integer :user_id

      t.timestamps
    end
  end
end
