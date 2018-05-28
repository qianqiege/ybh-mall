module Entities
  class UserAuth < Grape::Entity
    expose :id
    expose :authentication_token
  end
end
