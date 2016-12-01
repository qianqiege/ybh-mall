class AddWechatUserIdToTemperature < ActiveRecord::Migration[5.0]
  def change
    add_column :temperatures, :wechat_user_id, :integer
  end
end
