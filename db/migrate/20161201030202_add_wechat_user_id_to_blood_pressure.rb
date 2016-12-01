class AddWechatUserIdToBloodPressure < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_pressures, :wechat_user_id, :integer
  end
end
