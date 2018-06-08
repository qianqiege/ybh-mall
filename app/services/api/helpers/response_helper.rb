module Helpers
  module ResponseHelper
    def response_error(message = 'error', code)
      error!({status: code, message: message }, code)
    end

    def build_response code: 0, data: nil
      { code: code, data: data }
    end
  end
end
