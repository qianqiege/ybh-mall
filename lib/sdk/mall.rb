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

    def health_data(email,id)
      exec(:post, "examination_input/create_auto_identity_card?email=#{email}&identity_card=#{id}")
    end

    def record(identity_card)
      exec(:get, "record/check?id_number=#{identity_card}")
    end

    def api_heart_rate(identity_card,heart_rate,phone)
      exec(:post, "examination_input/heart_rate?id_number=#{identity_card}&heart_rate=#{heart_rate}&phone=#{phone}")
    end

    def api_blood_fat(identity_card,blood_fat,phone)
      exec(:post, "examination_input/blood_fat?id_number=#{identity_card}&blood_fat=#{blood_fat}&phone=#{phone}")
    end

    def api_unine(identity_card,unine,phone)
      exec(:post, "examination_input/unine?id_number=#{identity_card}&unine=#{unine}&phone=#{phone}")
    end

    def api_blood_glucose(identity_card,value,mens_type,phone)
      exec(:post, "examination_input/blood_glucose?id_number=#{identity_card}&value=#{value}&item_type=#{mens_type}&phone=#{phone}")
    end

    def api_blood_pressure(identity_card,diastolic,systolic,phone)
      exec(:post, "examination_input/blood_pressure?id_number=#{identity_card}&min_BloodPressure=#{diastolic}&max_BloodPressure=#{systolic}&phone=#{phone}")
    end

    def api_temperature(identity_card,temperature,phone)
      exec(:post, "examination_input/temperature?id_number=#{identity_card}&temperature=#{temperature}&phone=#{phone}")
    end

    def api_weight(identity_card,weight,phone)
      exec(:post, "examination_input/weight?id_number=#{identity_card}&weight=#{weight}&phone=#{phone}")
    end

    def api_ECG(identity_card,url,phone)
      exec(:post, "examination_input/ECG?id_number=#{identity_card}&url=#{url}&phone=#{phone}")
    end

    def tds_report(identity_card)
      exec(:get, "mall/tds_report?id_number=#{identity_card}")
    end

  end
end
