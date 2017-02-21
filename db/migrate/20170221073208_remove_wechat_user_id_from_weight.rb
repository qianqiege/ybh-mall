class RemoveWechatUserIdFromWeight < ActiveRecord::Migration[5.0]
  def change
    remove_column :weights, :wechat_user_id, :integer
    add_column :weights, :user_id, :integer
  end
end
