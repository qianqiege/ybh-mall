class CreateDayDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :day_deals do |t|
      t.integer :parallel_shop_id
      t.float :should_pay, default:0.00
      t.float :already_pay, default:0.00
      t.string :status, default:"pending"

      t.timestamps
    end
  end
end
