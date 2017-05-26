class RemoveRecommenderIdFromWechatUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :wechat_users, :recommender_id, :integral
  end
end
