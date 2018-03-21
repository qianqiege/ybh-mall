module Entities
  class User < Grape::Entity
    expose :id,
           :access_token,
           :expires_at,
           :telphone,
           :identity_card,
           :id_number,
           :name,
           :invitation_card,
           :invitation_id,
           :email,
           :type,
           :status,
           :lamp_number,
           :invitation_card,
           :is_partner,
           :staff_type,
           :parallel_shop_id
  end
end
