module Entities
  class HealthProgram < Grape::Entity
    expose :identity_card,
           :coding,
           :product,
           :created_at
  end
end
