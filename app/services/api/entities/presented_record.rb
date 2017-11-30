module Entities
  class PresentedRecord < Grape::Entity
    expose :reason,
           :number,
           :is_effective,
           :balance,
           :status,
           :desc,
           :type,
           :created_at
  end
end
