class CreateVipLvs < ActiveRecord::Migration[5.0]
  def change
    create_table :vip_lvs do |t|
      t.string :name

      t.integer :vip_type_id
      t.timestamps
    end
  end
end
