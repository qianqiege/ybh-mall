namespace :data do
  desc "update locking to available of users"
  task date_ycoin: :environment do
    puts "定时器启动，当前时间#{Time.current}"

    Order.where(activity_id: 12 , status: "wait_confirm", is_handle: "false").each do |order|

      @rules = order.activity.activity_rules.match_rules(order.price)
      @evaluation = EvaluationRecord.where(order_number: order.number).first

      @state = "no"
      if BloodPressure.where(user_id: order.user_id).where("created_at < ? AND created_at > ?",Time.current,order.created_at).present?
        @state = "yes"
      elsif BloodGlucose.where(user_id: order.user_id).where("created_at < ? AND created_at > ?",Time.current,order.created_at).present?
        @state = "yes"
      elsif Temperature.where(user_id: order.user_id).where("created_at < ? AND created_at > ?",Time.current,order.created_at).present?
        @state = "yes"
      elsif BloodFat.where(user_id: order.user_id).where("created_at < ? AND created_at > ?",Time.current,order.created_at).present?
        @state = "yes"
      elsif Unine.where(user_id: order.user_id).where("created_at < ? AND created_at > ?",Time.current,order.created_at).present?
        @state = "yes"
      elsif Ecg.where(user_id: order.user_id).where("created_at < ? AND created_at > ?",Time.current,order.created_at).present?
        @state = "yes"
      end

      @rules.map do |rule|

        if @state == "yes" && rule.rule == "有数据报告" && (Date.current - Date.parse(order.updated_at.to_s)).to_i == 15
          PresentedRecord.create(user_id: order.user_id,number: order.price * rule.percentage ,reason: "购买产品返还积分",is_effective:1,type:"Locking",wight: 3)
          puts "当前时间：#{Time.current},订单ID：#{order.id},用户ID：#{order.user_id},购买金额：#{order.price},是否有数据报告：有数据报告"
          if !@evaluation.nil?
            EvaluationRecord.create(order_id: order.id,order_number: order.number,evalation_number: @evaluation.evalation_number + 1 ,is_state: true)
            order.evaluation_number = order.evaluation_number - 1
          else
            EvaluationRecord.create(order_id: order.id,order_number: order.number,evalation_number: 1 ,is_state: true)
            order.evaluation_number = order.evaluation_number - 1
          end

          if order.evaluation_number == 0
            order.is_handle = true
          end
          order.save

        elsif @state == "no" && rule.rule == "无数据报告" && (Date.current - Date.parse(order.updated_at.to_s)).to_i == 15
          PresentedRecord.create(user_id: order.user_id,number: order.price * rule.percentage ,reason: "购买产品返还积分",is_effective:1,type:"Locking",wight: 3)
          puts "当前时间：#{Time.current},订单ID：#{order.id},用户ID：#{order.user_id},购买金额：#{order.price},是否有数据报告：无数据报告"

          if !@evaluation.nil?
            EvaluationRecord.create(order_id: order.id,order_number: order.number,evalation_number: @evaluation.evalation_number + 1 ,is_state: false)
            order.evaluation_number = order.evaluation_number - 1
          else
            EvaluationRecord.create(order_id: order.id,order_number: order.number,evalation_number: 1 ,is_state: false)
            order.evaluation_number = order.evaluation_number - 1
          end

          if order.evaluation_number == 0
            order.is_handle = true
          end
          order.save
        end
      end
    end

    puts "定时器结束，当前时间为#{Time.current}"
  end
end
