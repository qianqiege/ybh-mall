require 'singleton'

module Sdk
  class QQLbs

    attr_accessor :headers, :url, :secrect_key, :app_id, :host

    def initialize
      @headers = { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" }
      @url = Settings.qq_lbs.url
      @secrect_key = Settings.qq_lbs.secrect_key
      @app_id = Settings.qq_lbs.app_id
    end

    def geocoder_by_location(location)
      res = RestClient.get(@url + 'geocoder/v1/', { accept: :json, params: { location: location, key: @app_id }})
      JSON.parse(res.body)
    end

    # http://apis.map.qq.com/ws/geocoder/v1/?address=
    def geocoder_by_address(address)
      res = RestClient.get(@url + 'geocoder/v1/', { accept: :json, params: { address: address, key: @app_id }})
      JSON.parse(res.body)
    end

    def logger
      @@logger ||= Logger.new('./log/qq_lbs.log')
    end

  end
end
