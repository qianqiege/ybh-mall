class API::V1 < Grape::API

  mount ScrollThePicture
  mount User
  mount Wallet
  mount Work

end
