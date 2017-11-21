class CreateApplyCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :apply_codes do |t|
      t.text :desc
      t.integer :user_id

      t.timestamps
    end
  end
end
