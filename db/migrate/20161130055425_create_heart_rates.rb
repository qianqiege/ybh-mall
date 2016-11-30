class CreateHeartRates < ActiveRecord::Migration[5.0]
  def change
    create_table :heart_rates do |t|
      t.float :value
      t.datetime :time

      t.timestamps
    end
  end
end
