class CreatePresentedRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :presented_records do |t|
      t.references :presentable, polymorphic: true, index: true
      t.integer :user_id
      t.decimal :number, precision: 10, scale: 2
      t.string :reason

      t.timestamps
    end
  end
end
