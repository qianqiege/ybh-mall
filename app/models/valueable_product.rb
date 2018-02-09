class ValueableProduct < ApplicationRecord
	include ImageConcern
	belongs_to :contents_category

	validates :name, :price, :image, :desc, presence: true
end
