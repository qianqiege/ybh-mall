class AddWechatUserIdToHeartRate < ActiveRecord::Migration[5.0]
  def change
    add_column :heart_rates, :wechat_user_id, :integer
  end
end
