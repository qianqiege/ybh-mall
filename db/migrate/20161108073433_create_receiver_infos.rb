class CreateReceiverInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :receiver_infos do |t|
      t.string :receiver_address
      t.string :receiver
      t.string :receiver_telphone
      t.string :receiver_type
      t.string :receiver_date
      t.string :receiver_company

      t.integer :order_item_id
      t.timestamps
    end
  end
end
