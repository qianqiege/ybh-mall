module Entities
  class WechatUser < Grape::Entity
    expose :nickname,
           :id,
           :headimgurl
  end
end
