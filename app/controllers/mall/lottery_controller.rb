class Mall::LotteryController < Mall::BaseController
  def create
    lottery_prize = LotteryPrize.find_by(name: params[:info])

    user = User.find(current_user.user_id)
    user.lottery_number = user.lottery_number.to_i - 1
    if user.save
      UserPrize.create(lottery_prize_id: lottery_prize.id,user_id: current_user.user_id)
      rails.logger.info user
    end
  end

  def luck
    @lottery = LotteryPrize.where(is_show: true)
    @lottery_number = User.find(current_user.user_id).lottery_number
    @user_prize = UserPrize.where(user_id: current_user.user_id).limit(8)
  end
end
