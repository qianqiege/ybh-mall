class RemoveWechatUserIdFromTemperature < ActiveRecord::Migration[5.0]
  def change
    remove_column :temperatures, :wechat_user_id, :integer
    add_column :temperatures, :user_id, :integer
  end
end
