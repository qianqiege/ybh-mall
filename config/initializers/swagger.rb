GrapeSwaggerRails.options.url      = '/api/v1/swagger_doc'
GrapeSwaggerRails.options.app_url  = ''
GrapeSwaggerRails.options.app_name = 'api'
GrapeSwaggerRails.options.api_key_name = 'Access-Token'
GrapeSwaggerRails.options.api_key_type = 'header'

GrapeSwaggerRails.options.before_action_proc = proc {
  api_type = if params[:api_type].in? %w(api)
               params[:api_type]
             else
               'api'
             end
  GrapeSwaggerRails.options.url = "/#{api_type}/v1/swagger_doc"
}