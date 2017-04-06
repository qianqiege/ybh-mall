class CreateLssueCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :lssue_currencies do |t|
      t.string :account
      t.decimal :count
      t.decimal :income
      t.decimal :expenditure

      t.timestamps
    end
  end
end
