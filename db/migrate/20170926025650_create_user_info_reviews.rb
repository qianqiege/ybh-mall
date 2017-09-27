class CreateUserInfoReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :user_info_reviews do |t|
      t.string :work_province
      t.string :work_city
      t.string :work_street
      t.string :resident_province
      t.string :resident_city
      t.string :resident_street
      t.string :identity
      t.string :state
      t.string :desc
      t.integer :user_id

      t.timestamps
    end
  end
end
