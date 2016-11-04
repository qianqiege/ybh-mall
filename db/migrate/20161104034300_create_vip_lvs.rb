class CreateVipLvs < ActiveRecord::Migration[5.0]
  def change
    create_table :vip_lvs do |t|
      t.integer :vip_type_id
      t.integer :set_meal_id
      t.string :level
      t.string :standard
      t.string :rights

      t.timestamps
    end
  end
end
