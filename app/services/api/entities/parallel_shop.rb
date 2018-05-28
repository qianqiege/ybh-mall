module Entities
  class ParallelShop < Grape::Entity
    expose :title
    expose :address
    expose :main_business
    expose :image
    expose :desc
    expose :status
    expose :province
    expose :city
    expose :street
    expose :detail
    expose :plan_id
    expose :admin_user_id
    expose :settlement_ratio
    expose :latitude
    expose :longitude
    expose :is_hot
    expose :left_and_right_ratio
    expose :shop_type
  end
end