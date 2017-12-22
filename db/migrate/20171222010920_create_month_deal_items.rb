class CreateMonthDealItems < ActiveRecord::Migration[5.0]
  def change
    create_table :month_deal_items do |t|
      t.integer :product_id
      t.integer :month_deal_id
      t.integer :amount, default:0
      t.float :price
      t.float :sub_total

      t.timestamps
    end
  end
end
