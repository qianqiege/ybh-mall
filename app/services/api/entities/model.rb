module Entities
  class Model < Grape::Entity
    expose :id
    # expose :updated_at
    expose :created_at
  end
end
