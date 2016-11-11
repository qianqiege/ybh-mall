class CreateMemberRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :member_ranks do |t|
      t.string :name
      t.string :image

      t.integer :vip_type_id
      t.timestamps
    end
  end
end
