class Slide < ApplicationRecord
  include ImageConcern
  HUMAN_TYPE = { 'Slide::Home' => '首页轮播图', 'Slide::Mall' => '商品首页轮播图' }.freeze
end
