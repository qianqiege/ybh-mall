class Slide < ApplicationRecord
  include ImageConcern
  HUMAN_TYPE = { '1' => '首页轮播图', '2' => '商品首页轮播图' }.freeze
  scope :top , ->(type) { where(is_show: true, tp: type).order(weight: :asc).limit(3) }
end
