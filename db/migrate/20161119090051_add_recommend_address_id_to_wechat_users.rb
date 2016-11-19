class AddRecommendAddressIdToWechatUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :wechat_users, :used_address_id, :integer
  end
end
