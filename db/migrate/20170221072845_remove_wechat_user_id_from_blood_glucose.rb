class RemoveWechatUserIdFromBloodGlucose < ActiveRecord::Migration[5.0]
  def change
    remove_column :blood_glucoses, :wechat_user_id, :integer
    add_column :blood_glucoses, :user_id, :integer
  end
end
