class Mall::LotteryController < Mall::BaseController
  def create
    lottery_prize = LotteryPrize.find_by(name: params[:info])
    UserPrize.create(lottery_prize_id: lottery_prize.id,user_id: current_user.user_id,state: "panding")
  end

  def luck
    @lottery = LotteryPrize.where(is_show: true)
  end
end
