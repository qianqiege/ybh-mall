module ImageConcern
  extend ActiveSupport::Concern

  included do
    mount_uploader :image, ImageUploader
    include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    def thumb_url
      image.thumb.url
    end

    def icon_url
      image.icon.url
    end
  end
end
