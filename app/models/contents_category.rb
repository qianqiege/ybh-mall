class ContentsCategory < ApplicationRecord
  has_many :products
  has_many :downs, class_name: "ContentsCategory", foreign_key: "up_id"
  belongs_to :up, class_name: "ContentsCategory"
  has_many :valueable_products

  def second_category
    downs
  end

  def all_products
    self.products.where(is_show: 1)
  end
end
