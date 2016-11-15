class AddMobileToWechatUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :wechat_users, :mobile, :string
  end
end
