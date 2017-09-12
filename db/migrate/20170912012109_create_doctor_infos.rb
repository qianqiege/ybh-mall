class CreateDoctorInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_infos do |t|
      t.string :name
      t.string :image
      t.string :skill
      t.integer :shop_id

      t.timestamps
    end
  end
end
