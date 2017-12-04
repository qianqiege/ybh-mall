class API::V1 < Grape::API
  mount UserApi
  mount MallApi
end
