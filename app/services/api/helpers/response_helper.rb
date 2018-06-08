module Helpers
  module ResponseHelper
    def response_error(message = 'error', code)
      error!({status: code, message: message }, code)
    end

    def build_response code, data
      { code: code, data: data }
    end
  end
end
