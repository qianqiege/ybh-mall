class HealthDataController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    idcard = params["identity_card"]
    phone_account = params["phone"]
    only_number = params["only_number"]
    @temporary_data = TemporaryData.new(identity_card: idcard,phone: phone_account,only_number: only_number)

    if @temporary_data.save
      render json: @temporary_data
    else
      render_error("错误")
    end
  end
end
