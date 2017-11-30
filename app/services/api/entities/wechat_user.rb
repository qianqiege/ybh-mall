module Entities
  class WechatUser < Grape::Entity
    expose :nickname,
           :headimgurl
  end
end
