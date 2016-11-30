class AddWechatUserIdToExamineRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :examine_records, :wechat_user_id, :integer
  end
end
