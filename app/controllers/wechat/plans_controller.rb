class Wechat::PlansController < Wechat::BaseController
  #平行系统计划
  def index
    @sharing_plan_types = SharingPlan.all #所有计划
    @plan_records_all = Plan.where(user_id: current_user.user_id) #当前用户的所有计划
    @plan_records = @plan_records_all.where(is_end: false) #当前用户未结束的所有计划
    @user_plans_type = SharingPlan.joins(:plans).where("plans.user_id = ? AND plans.is_end = ?", current_user.user_id, false).pluck(:plan_type)
    # @user_plans_type = @plan_records.pluck(:plan_type)
  end

  def show
    @plan = Plan.find(params[:id])
    @plan_rule = @plan.plan_rule
    start_money = @plan_rule.start_money
    earning_ratio = @plan_rule.sharing_plan.earning_ratio
    @partners = @plan.partners
    @settlement = start_money * earning_ratio
    @permit_count = @plan_rule.sharing_plan.invite_count
  end

  def new
    @sharing_plan = SharingPlan.find(params[:id]) #发起计划大类实例
    @plan_rules = @sharing_plan.plan_rules
    @current_user_id = current_user.user_id #当前user_id
    @invite_plan_id = params[:invite_plan_id]
  end

  def create
    @plan = Plan.new(set_plan)
    if @plan.save
      logger.info("==================保存成功=========================")
      if params[:plan][:payment] == "1" || params[:plan][:plan_rule_id] == "1"
        logger.info("==================线下付款=========================")
        redirect_to action: :index
      else
        logger.info("==================线上付款=========================")
        redirect_to action: :pay, id: @plan.id
      end
    else
      logger.info("==================保存失败=========================")
      render "/wechat/plans/new"
    end
  end

  def show_invitation_code
    url = choice_wechat_plan_url(params[:format])
    @qrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
  end

  def choice
    @sharing_plan_types = SharingPlan.all #所有计划
    @user_plans_type = SharingPlan.joins(:plans).where("plans.user_id = ? AND plans.is_end = ?", current_user.user_id, false).pluck(:plan_type)
    @invite_plan_id = params[:id] #邀请人id
  end

  def pay
    @no_fotter = true
    @plan = Plan.find(params["id"])
    @trade_merge_pay_params = @plan.fast_pay.trade_merge_pay_params_plan(params["payment"])
  end

  # 展示平行店文件
  def index_files

  end

  # 展示199计划文件
  def index_community_files

  end

  # 展示百万创客计划文件
  def index_maker_files

  end

  private
  def set_plan
    params.require(:plan).permit(:user_id, :invite_plan_id, :plan_rule_id, :price, :payment)
  end
end
