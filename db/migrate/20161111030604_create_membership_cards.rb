class CreateMembershipCards < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_cards do |t|
      t.string :name
      t.string :image

      t.integer :member_rank_id
      t.integer :setmeal_id
      t.integer :serve_id
      t.integer :house_poperty_id
      t.integer :stock_right_id
      t.timestamps
    end
  end
end
