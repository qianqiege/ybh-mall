class RemoveWechatUserIdFromExamineRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :examine_records, :wechat_user_id, :string
    add_column :examine_records, :user_id, :string
  end
end
