class Wechat::PlansController < Wechat::BaseController
  def create_plan
    user_id = WechatUser.find_by(id: params[:current_user].to_i).user.id
    if params[:capital_id]
      plan = Plan.new(user_id: user_id, is_capital: false, active: false, is_maker: false, capital_id: params[:capital_id].to_i, invite_plan_id: params[:invite_plan_id].to_i, plan_type: '199')
      if plan.save
        if plan.capital_id
          arr = Plan.where(capital_id: plan.capital_id)
          if arr.length == 9
            t = Plan.find_by(user_id: plan.capital_id)
            t.active = true
            t.save
            arr.each do |f|
              f.active = true
              f.save
            end
          end
        end

        # 更新队长的伙伴id数组
        # capital = Plan.find_by(user_id: params[:capital_id])
        # capital.partner_ids.push(plans.id)
        # capital.save

        redirect_to '/wechat/community/index'
      else
        redirect_to :back
      end
    else
      plan = Plan.new(user_id: user_id, is_capital: true, active: false, is_maker: false, plan_type: '199')
      if plan.save
        redirect_to '/wechat/community/index'
      else
        redirect_to :back
      end
    end
  end

  # 展示平行店文件
  def index_files

  end

  def show
    @plan = Plan.find(params[:id])
    @plan_rule = PlanRule.find_by(plan_type: @plan.plan_type)
  end

  # 展示199计划文件
  def index_community_files

  end

  # 展示百万创客计划文件
  def index_maker_files

  end

  def show_invitation_code
    url = wechat_plans_path(plan_id: params[:format])
    @qrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
  end

  #消费计划
  def index
    @plan_rules = PlanRule.all
    @plans = Plan.where(user_id: current_user.user.id)
    @user_plans = @plans.pluck(:plan_type)
    #包含哪些计划
  end

end
