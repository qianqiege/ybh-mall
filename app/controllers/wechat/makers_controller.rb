class Wechat::MakersController < Wechat::BaseController
  def plan
  end

  def plan_details
  end

  def protocol
    @user_id = params[:user_id]
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
