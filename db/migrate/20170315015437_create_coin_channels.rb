class CreateCoinChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :coin_channels do |t|
      t.string :name

      t.timestamps
    end
  end
end
