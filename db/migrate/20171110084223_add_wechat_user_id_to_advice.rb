class AddWechatUserIdToAdvice < ActiveRecord::Migration[5.0]
  def change
    add_column :advices, :wechat_user_id, :integer
  end
end
