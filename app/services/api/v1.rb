class API::V1 < Grape::API

  mount ScrollThePicture
  mount User
  mount Wallet
  mount Work
  mount MallApi

  add_swagger_documentation

end
