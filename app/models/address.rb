class Address < ApplicationRecord
  belongs_to :wechat_user
  validates :wechat_user, :contact_name, :mobile, :detail,
            :province, :city, :street, presence: true
end
