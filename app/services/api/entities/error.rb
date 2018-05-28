module Entities
  class Error < Grape::Entity
    expose :status
    expose :message
  end
end
