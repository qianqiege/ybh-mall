class ContentsCategory < ApplicationRecord
  has_many :products
  has_many :downs, class_name: "ContentsCategory", foreign_key: "up_id"
  belongs_to :up, class_name: "ContentsCategory"
  has_many :value_products
end
