class CreateVipRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :vip_records do |t|
      t.string :name
      t.integer :sex, :default => 0
      t.string :address
      t.datetime :birthday
      t.string :identity_card
      t.string :telephone
      t.string :mobile
      t.string :emergency_contact

      t.timestamps
    end
  end
end
