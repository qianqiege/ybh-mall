class VipType < ApplicationRecord
  mount_uploader :image, ImageUploader

  def icon_url
    image.icon.url
  end

end
