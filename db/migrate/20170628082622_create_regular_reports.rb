class CreateRegularReports < ActiveRecord::Migration[5.0]
  def change
    create_table :regular_reports do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
