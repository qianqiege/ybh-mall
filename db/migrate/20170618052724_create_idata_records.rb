class CreateIdataRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :idata_records do |t|
      t.references :recordable, polymorphic: true
      t.string :state
      t.text :message
      t.text :detail
      t.text :row_data
      t.integer :wechat_user_id
      t.string :service_id

      t.timestamps
    end
  end
end
