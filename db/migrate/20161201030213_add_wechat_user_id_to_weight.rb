class AddWechatUserIdToWeight < ActiveRecord::Migration[5.0]
  def change
    add_column :weights, :wechat_user_id, :integer
  end
end
