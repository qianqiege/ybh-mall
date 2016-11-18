class Address < ApplicationRecord
  belongs_to :wechat_user
  validates :wechat_user, :contact_name, :mobile, :detail,
            :province, :city, :street, presence: true
  VALID_MOBILE_REGEX = /\A(13[0-9]|15[012356789]|17[0123456789]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, format: { with: VALID_MOBILE_REGEX, message: '格式不正确' }

  def display_detail
    "#{ChinaCity.get(province)} #{ChinaCity.get(city)} #{ChinaCity.get(street)} #{detail}"
  end
end
