module Entities
  class User < Grape::Entity
    expose :id
    expose :access_token
    expose :expires_at
    expose :telphone
    expose :identity_card
    expose :id_number
    expose :name
    expose :invitation_card
    expose :invitation_id
    expose :email
    expose :type
    expose :status
    expose :lamp_number
    expose :invitation_card
    expose :is_partner
    expose :staff_type
    expose :parallel_shop_id
  end
end
