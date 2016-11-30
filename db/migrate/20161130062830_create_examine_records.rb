class CreateExamineRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :examine_records do |t|
      t.string :name
      t.integer :user_id
      t.string :idcard

      t.timestamps
    end
  end
end
