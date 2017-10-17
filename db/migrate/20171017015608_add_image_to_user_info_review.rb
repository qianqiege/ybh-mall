class AddImageToUserInfoReview < ActiveRecord::Migration[5.0]
  def change
    add_column :user_info_reviews, :image, :string
    add_column :user_info_reviews, :score, :string
    add_column :user_info_reviews, :ranking, :string
  end
end
