class AddRecommenderToWechatUser < ActiveRecord::Migration[5.0]
  def change
    add_column :wechat_users, :recommender, :integer
  end
end
