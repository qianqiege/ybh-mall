class CreateAppraises < ActiveRecord::Migration[5.0]
  def change
    create_table :appraises do |t|
      t.integer :user_id
      t.string :result
      t.string :category
      t.string :number
      t.string :doctor_name

      t.timestamps
    end
  end
end
