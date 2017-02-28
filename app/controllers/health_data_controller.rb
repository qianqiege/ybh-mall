class HealthDataController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    idcard = params["identity_card"]
    phone_account = params["phone"]
    @temporary_data = TemporaryDatum.new(identity_card: idcard,phone: phone_account)
    if @temporary_data.save
      render json: @temporary_data
    else
      render_error("错误")
    end
    count = TemporaryDatum.count
    if count > 50
      @data = TemporaryDatum.limit(50).order(id: :desc).offset(50)
      @data.each do |data|
        data.destroy
      end
    end
  end
end
