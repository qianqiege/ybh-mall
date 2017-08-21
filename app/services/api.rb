# require 'grape-swagger'

class API < Grape::API
  default_format :json

  format :json

  rescue_from :all, backtrace: true
  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response('{ "status": 404, "message": "Not Found." }', 404)
  end

  mount API::V1
  # mount API::V2 # for future

end
