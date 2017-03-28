class HealthRecordGiveYcoinController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    idcard = params["id_number"]
    programs_number = params["programs_number"]
    result = params["result"]
    doctor_name = params["doctor_name"]
    category = params["category"]
    user = User.find_by(identity_card: idcard)

    if !user.nil?
      appraise = Appraise.where(user_id: user.id, number: programs_number)
      if !appraise.nil?
        @user_appraise = Appraise.new(user_id: user.id,
                                     result: result,
                                     category: category,
                                     number: programs_number,
                                     doctor_name: doctor_name
                                     )
        @user_appraise.save
        
        if @user_appraise.save
          render json: @user_appraise
        else
          render_error("错误")
        end
      end
    end
  end
end
