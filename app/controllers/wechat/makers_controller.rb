class Wechat::MakersController < Wechat::BaseController
  def plan
      @plans = Plan.where(user_id:current_user.user.id, is_maker:true)
  end

  def plan_details
      @plan = Plan.find_by(id:params[:format])
      @parallel_shops = @plan.parallel_shops
  end

  def protocol
      # 标识当前用户 是否有此类型的计划
      # @wheter_has_plan = nil
      # if params[:plan_id]
      #     @plan = Plan.find(params[:plan_id])
      #     @wheter_has_plan = current_user.user.plans.find_by(plan_type: '177')
      # end
  end

  #创客付款
  def create_plan_exchange
    format_data = {
      price: params[:price].to_f,
      payment: params[:payment],
      plan_type: '177'
    }
    @plan = User.find(current_user.user_id).plans.new(format_data)
    @plan.is_capital = true
    @plan.active = false
    @plan.is_maker = true

    # 判断是否为 通过队长二维码 扫码发起的计划
    if params[:plan_id] != ""
      # 更新伙伴计划中的
      # capital_id 和 invite_plan_id(邀请队长的plan_id)
      @plan.capital_id = Plan.find(params[:plan_id]).user_id
      @plan.is_capital = false
      @plan.invite_plan_id = params[:plan_id]
    end

    if @plan.save
        if params["payment"] == "PAYMENT_TYPE_NULL"
            redirect_to '/wechat/makers/plan'
        else
            redirect_to wechat_makers_plan_pay_path(@plan)
        end

    end
  end

  #支付确认
  def plan_pay
    @no_fotter = true
    @plan = User.find(current_user.user_id).plans.find(params[:format])
    Sdk::FastPay.new(@plan)
    @trade_merge_pay_params = @plan.fast_pay.trade_merge_pay_params_plan(@plan.payment)
  end


  def instructions
  end

  def invite_code
  end

  def create
    user = current_user.user
    if !user.nil?
      user.maker_id = params[:format].to_i
      if user.save
        redirect_to '/user/maker_code'
        return
      end
    end
  end
end
