class CreateVipRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :vip_records do |t|
      t.string :name
      t.string :sex
      t.string :address
      t.date :birthday
      t.integer :identity_card
      t.string :telephone
      t.string :mobile
      t.string :emergency_contact

      t.integer :vip_info_id
      t.integer :user_id
      t.timestamps
    end
  end
end
