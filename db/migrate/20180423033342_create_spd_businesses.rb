class CreateSpdBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :spd_businesses do |t|
w
      t.integer  :up_id
      t.string   :business_number
      t.string   :out_warehouse
      t.string   :in_warehouse
      t.string   :type
      t.string   :purchase_status
      t.string   :allocate_status
      t.datetime :datetime
      t.string   :preparer
      t.string   :reviewer
      t.string   :discount
      t.string   :preferential
      t.string   :amounts_payable
      t.boolean  :is_amended
      t.datetime :order_date
      t.string   :pay_status

      t.timestamps
    end

  end
end
