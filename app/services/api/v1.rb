class API::V1 < Grape::API

  mount ScrollThePicture
  mount User
  mount Wallet
  mount Work
  mount Auth
  # mount MallApi

  add_swagger_documentation

end
