require 'grape-swagger'
require 'grape_logging'

class API < Grape::API
  default_format :json

  helpers ::Helpers::BaseHelper
  helpers ::Helpers::AuthenticationHelper
  helpers ::Helpers::ResponseHelper
  helpers ::Helpers::SharedParamsHelper
  helpers ::Helpers::ApiStrongParametersHelper

  rescue_from :all, backtrace: true

  # 记录不存在
  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response('{ "status": 404, "message": "Not Found." }', 404)
  end

  # 记录校验异常
  rescue_from ActiveRecord::RecordInvalid do |e|
    response_error e.message, 400
  end

  format :json

  log_file = File.open(Rails.root.join('log/request.log'), 'a')
  log_file.sync = true
  logger Logger.new GrapeLogging::MultiIO.new(STDOUT, log_file)

  use GrapeLogging::Middleware::RequestLogger,
      logger: logger,
      formatter: GrapeLogging::Formatters::Default.new,
      include: [
          GrapeLogging::Loggers::Response.new,
          GrapeLogging::Loggers::FilterParameters.new,
          GrapeLogging::Loggers::ClientEnv.new,
      # GrapeLogging::Loggers::RequestHeaders.new
      ]

  before do
    unless is_api_detecting?
      # TODO: 安全校验
      # check_app_secret
      # log_request
      authenticate! if require_authentication?
    end
  end

  mount API::V1
  # mount API::V2 # for future

end
