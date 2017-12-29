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
