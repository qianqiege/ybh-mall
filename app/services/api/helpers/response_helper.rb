module Helpers
  module ResponseHelper
    def response_error(message = 'error', code)
      error!({status: code, message: message }, code)
    end
  end
end
