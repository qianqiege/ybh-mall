require 'net/http'
require 'uri'

class Express
  def self.query(number)
    uri = URI.parse("http://route.showapi.com/64-19")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "nu" => number,
      "com" => "auto",
      "showapi_appid" => "43544",
      "showapi_sign" => "f151359ee58a4e42bb1a8b81c44366ee"
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end


    JSON.parse(response.body)
  end
end
