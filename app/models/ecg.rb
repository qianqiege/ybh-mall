class Ecg < ApplicationRecord
  include ImageConcern
  belongs_to :user
  validates :url, presence: true
end
