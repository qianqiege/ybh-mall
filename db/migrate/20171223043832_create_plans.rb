class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.string :partner_ids
      t.boolean :is_capital
      t.integer :capital_id
      t.boolean :active
      t.boolean :is_maker
      t.float :money, default:0.00

      t.timestamps
    end
  end
end
