module Sdk
  class Mall
    attr_accessor :app_id, :secret_key, :api_url

    def initialize
      @app_id = Settings.external.app_id
      @secret_key = Settings.external.secret_key
      @api_url = Settings.external.api_url
    end

    def exec(method, url, payload ={})
      headers = {
        "Content-Type": "application/json",
        'App-Id': app_id
      }
      request = RestClient::Request.new({
        url: api_url + url,
        headers: headers,
        method: method,
        payload: payload
      })
      signed_request = ApiAuth.sign!(request, app_id, secret_key)
      JSON.parse(signed_request.execute)
    end

    def patient_records
      exec(:get, "patient_records")
    end

    def record(identity_card)
      exec(:get, "record/check?id_number=#{identity_card}")
    end
  end
end
