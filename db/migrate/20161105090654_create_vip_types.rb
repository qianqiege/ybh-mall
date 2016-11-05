class CreateVipTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :vip_types do |t|
      t.string :name
      t.string :image
      t.string :remark

      t.timestamps
    end
  end
end
