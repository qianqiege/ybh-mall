class HealthRecordGiveYcoinController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create

    idcard = params["id_number"]
    programs_number = params["programs_number"]
    result = params["result"]
    doctor_id = params["doctor_id"]
    category = params["category"]
    number = params["number"]
    user = User.find_by(identity_card: idcard)

    if !user.nil?
      @user_appraise = Appraise.new(user_id: user.id,
                                   result: result,
                                   category: category,
                                   number: programs_number,
                                   doctor_name: doctor_id)

      if @user_appraise.save
        evaluate_coin(programs_number,number,user,doctor_id)
        render json: @user_appraise
      end
    end
  end

  def evaluate_coin(programs_number,number,user,doctor_id)
    products = Order.find_by(programs_number: programs_number)
    if products.price > 0
      line_items = products.line_items.pluck(:product_id)
      price = products.price

      line_items.each do |product|
        @rule = EvaluationRule.where(evaluation_id: Evaluation.find_by(product_id: product).id)
        @rule = rule.find_by(weight: number)
      end
      PresentedRecord.create(user_id: user.id, number: price * @rule.user_proportion, reason: "评价完成，赠送积分",is_effective:1, type:"Available", wight: 20)
      doctor_user = User.find_by(identity_card: doctor_id)
      PresentedRecord.create(user_id: doctor_user.id, number: @rule.doctor, reason: "评价完成，赠送积分",is_effective:1, type:"Available", wight: 20)
    end
  end

end
