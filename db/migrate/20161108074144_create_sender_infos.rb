class CreateSenderInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :sender_infos do |t|
      t.string :sender
      t.string :sender_address
      t.string :sender_telphone
      t.string :sender_date
      t.string :sender_type
      t.string :sender_company

      t.integer :order_item_id
      t.timestamps
    end
  end
end
