require 'net/http'
require 'uri'

class Express
  def self.query(number)
    uri = URI.parse("http://www.sojson.com/kuaidi/byNo.shtml")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "no" => number,
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
