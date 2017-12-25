class Wechat::MakersController < Wechat::BaseController
  def plan
      @plans = Plan.where(user_id:current_user.user.id, is_maker:true)
  end

  def plan_details
      @plan = Plan.find_by(id:params[:format])
  end

  def protocol
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
