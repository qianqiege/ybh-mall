class Slide < ApplicationRecord
  mount_uploader :image, ImageUploader

  def thumb_url
    image.thumb.url
  end
end
