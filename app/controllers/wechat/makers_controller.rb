class Wechat::MakersController < Wechat::BaseController
  def plan
      @plans = Plan.where(user_id:current_user.user.id, is_maker:true)
  end

  def plan_details
      @plan = Plan.find_by(id:params[:format])
  end

  def protocol
  end
  
  #创客付款
  def create_plan_exchange
    format_data = {
      price: params[:price].to_f,
      payment: params[:payment]
    }
    @plan = User.find(current_user.user_id).plans.new(format_data)
    @plan.is_capital = true
    @plan.active = false
    @plan.is_maker = true

    if @plan.save
      redirect_to wechat_makers_plan_pay_path(@plan)
    end
  end

  #支付确认
  def plan_pay
    @no_fotter = true
    @plan = User.find(current_user.user_id).plans.find(params[:format])
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
