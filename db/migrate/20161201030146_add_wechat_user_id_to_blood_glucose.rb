class AddWechatUserIdToBloodGlucose < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_glucoses, :wechat_user_id, :integer
  end
end
