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

    def record(identity_card)
      exec(:get, "record/check?id_number=#{identity_card}")
    end

    # def examination_input(identity_card,heart_rate)
    #   exec(:post, "examination_input/heart_rate?",{id_number: identity_card , heart_rate: heart_rate})
    # end

    def api_heart_rate(identity_card,heart_rate)
      exec(:post, "examination_input/heart_rate?id_number=#{identity_card}&heart_rate=#{heart_rate}")
    end

    def api_blood_glucose(identity_card,b_glucose,a_glucose)
      exec(:post, "examination_input/blood_glucose?id_number=#{identity_card}&b_BloodGlucose=#{b_glucose}&a_BloodGlucose=#{a_glucose}")
    end

    def api_blood_pressure(identity_card,diastolic,systolic)
      exec(:post, "examination_input/blood_pressure?id_number=#{identity_card}&min_BloodPressure=#{diastolic}&max_BloodPressure=#{systolic}")
    end

    def api_temperature(identity_card,temperature)
      exec(:post, "examination_input/temperature?id_number=#{identity_card}&temperature=#{temperature}")
    end

    def api_weight(identity_card,weight)
      exec(:post, "examination_input/weight?id_number=#{identity_card}&weight=#{weight}")
    end

    # def examination_input
    #   exec(:post,"examination_input/heart_rate?id_number=11111111111111&heart_rate=95")
    # end

  end
end
