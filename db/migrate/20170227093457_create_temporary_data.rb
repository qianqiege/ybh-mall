class CreateTemporaryData < ActiveRecord::Migration[5.0]
  def change
    create_table :temporary_data do |t|
      t.string :identity_card
      t.string :phone
      t.string :only_number

      t.timestamps
    end
  end
end
