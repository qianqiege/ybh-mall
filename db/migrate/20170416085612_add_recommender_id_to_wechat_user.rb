class AddRecommenderIdToWechatUser < ActiveRecord::Migration[5.0]
  def change
    add_column :wechat_users, :recommender_id, :integer
  end
end
