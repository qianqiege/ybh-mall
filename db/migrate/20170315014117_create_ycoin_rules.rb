class CreateYcoinRules < ActiveRecord::Migration[5.0]
  def change
    create_table :ycoin_rules do |t|
      t.string :name
      t.decimal :number

      t.timestamps
    end
  end
end
