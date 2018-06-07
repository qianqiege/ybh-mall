module Entities
  class Product < Model
    expose :name
    expose :image
    expose :original_product_price
    expose :now_product_price
    expose :only_number
    expose :shop_count
    expose :desc
    expose :general
    expose :product_sort
    expose :priority
    expose :is_consumption
    expose :packaging
    expose :is_custom_price
    expose :sort
    expose :led_away_category
    expose :led_away_price
    expose :yter_profile
    expose :value_batch
    expose :match, safe: true
    expose :category, safe: true
  end
end