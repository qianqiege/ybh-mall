module Entities
  class Integral < Grape::Entity
    expose :user_id,
           :locking,
           :available,
           :not_exchange,
           :cash,
           :not_cash
  end
end
