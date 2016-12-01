class AddUserIdToWechatUser < ActiveRecord::Migration[5.0]
  def change
    add_column :wechat_users, :user_id, :integer
  end
end
