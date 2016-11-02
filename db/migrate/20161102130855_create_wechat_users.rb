class CreateWechatUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :wechat_users do |t|
      t.string :open_id
      t.string :nickname
      t.string :headimgurl
      t.integer :subscribe
      t.text :access_token_info
      t.text :auth_hash

      t.timestamps
    end
  end
end
