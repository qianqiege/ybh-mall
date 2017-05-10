class CreateExchangeRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_records do |t|

      t.timestamps
    end
  end
end
