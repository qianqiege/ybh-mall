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
           :family_health_manager,
           :family_doctor,
           :health_manager,
           :staff_type
  end
end
