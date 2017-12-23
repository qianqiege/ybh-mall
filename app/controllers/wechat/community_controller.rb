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
  end

  def invite
    @user_id = WechatUser.find(current_user).user.id
    if Plan.find_by(user_id:@user_id, is_capital:true)
      url = wechat_community_commitment_path({user_id: @user_id})
      @qrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
    else
      redirect_to '/wechat/community/index'
    end
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
