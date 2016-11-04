class CreateVipTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :vip_types do |t|
      t.string :vip_type
      t.string :name
      

      t.timestamps
    end
  end
end
