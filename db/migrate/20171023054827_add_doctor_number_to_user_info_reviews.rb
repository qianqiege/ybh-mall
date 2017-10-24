class AddDoctorNumberToUserInfoReviews < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_info_reviews, :doctor_number, :string
  	add_column :user_info_reviews, :doctor_image, :string
  	add_column :user_info_reviews, :education_image, :string
  	add_column :user_info_reviews, :other_image, :string 
  end
end
