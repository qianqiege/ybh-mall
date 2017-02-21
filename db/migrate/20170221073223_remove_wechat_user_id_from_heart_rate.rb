class RemoveWechatUserIdFromHeartRate < ActiveRecord::Migration[5.0]
  def change
    remove_column :heart_rates, :wechat_user_id, :integer
    add_column :heart_rates, :user_id, :integer
  end
end
