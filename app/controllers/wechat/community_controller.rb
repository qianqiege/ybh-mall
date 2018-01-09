class Wechat::CommunityController < Wechat::BaseController
  def index

  end

  def plandetail
      @plan = Plan.find_by(id:params[:format])
  end

  def instruct

  end

  def commitment
    @user_id = params[:user_id]
    @plan = params[:plan]

    # 标识当前用户 是否有此类型的计划
    @wheter_has_plan = nil
    if params[:plan]
        @plan = Plan.find(params[:plan])
        @wheter_has_plan = current_user.user.plans.find_by(plan_type: '199')
    end
  end

  def invite
    @user_id = WechatUser.find(current_user).user.id
    @plan = params[:format]
    url = wechat_community_commitment_path(user_id: @user_id, plan:@plan)
    @qrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
  end

  def renew

  end

  def create
      user = current_user.user
      if !user.nil?
        user.community_id = params[:format].to_i
        if user.save
          redirect_to '/user/community_code'
          return
        end
      end
    end

end
