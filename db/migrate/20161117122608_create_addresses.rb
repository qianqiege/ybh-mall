class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :contact_name
      t.string :mobile
      t.boolean :is_default, default: false
      t.string :detail
      t.string :province
      t.string :city
      t.string :street
      t.belongs_to :wechat_user

      t.timestamps
    end
  end
end
