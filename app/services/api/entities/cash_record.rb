module Entities
  class CashRecord < Grape::Entity
    expose :number,
           :reason,
           :is_effective,
           :status,
           :type,
           :account,
           :desc,
           :created_at
  end
end
