class CreateDayDealItems < ActiveRecord::Migration[5.0]
  def change
    create_table :day_deal_items do |t|
      t.integer :product_id
      t.integer :day_deal_id
      t.integer :amount
      t.float :price
      t.float :sub_total

      t.timestamps
    end
  end
end
