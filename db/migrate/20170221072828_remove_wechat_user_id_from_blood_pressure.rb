class RemoveWechatUserIdFromBloodPressure < ActiveRecord::Migration[5.0]
  def change
    remove_column :blood_pressures, :wechat_user_id, :integer
    add_column :blood_pressures, :user_id, :integer
  end
end
