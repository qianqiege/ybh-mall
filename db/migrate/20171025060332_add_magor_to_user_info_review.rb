class AddMagorToUserInfoReview < ActiveRecord::Migration[5.0]
  def change
    add_column :user_info_reviews, :magor, :string
    add_column :user_info_reviews, :info, :string
  end
end
