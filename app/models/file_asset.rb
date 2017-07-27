class FileAsset < ApplicationRecord
  mount_uploader :location, FileAssetUploader
  validates :name, :location, presence: true
end
