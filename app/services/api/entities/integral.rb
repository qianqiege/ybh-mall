module Entities
  class Integral < Grape::Entity
    expose :locking,
           :available,
           :not_exchange,
           :cash,
           :not_cash
  end
end
