class Slide < ApplicationRecord
  include ImageConcern
  HUMAN_TYPE = { '1' => '首页轮播图',
                '2' => '商品首页轮播图',
                '3'=>'服务首页图片' ,
                '4'=>'御邦会会员卡图片',
                '6'=>'方案首页轮播图',
                '7'=>'订阅服务轮播图',
                '8'=>'商盟首页轮播图片',
                '9' => '点亮心灯轮播图片'}.freeze
  scope :top , ->(type) { where(is_show: true, tp: type).order(weight: :asc).limit(9) }
end
