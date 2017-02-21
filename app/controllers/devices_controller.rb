class DevicesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def putmessage
    device = Sdk::Device.new
    result = request.body.read
    if result.include?("jkezData")
      jkezData = result.gsub /jkezData=/, ''
      data = device.decryption(jkezData)
      render json: "success", layout: nil
    else
      render json: "fail", layout: nil
    end
  end
end
