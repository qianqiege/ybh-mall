namespace :ybz_vip do
  desc "reward user"
  task reward: :environment do
    puts "定时器启动，当前时间#{Time.current}"

    user = User.all
    user.each do |user|
      number = user.ybz_number
      integral = Integral.find_by(user_id: user.id)
      if number > 0 && number <= 5
        coin = number * 25000 * 0.1
        if integral.update(available: integral.available + coin,exchange: integral.exchange + coin,not_appreciation: integral.not_appreciation + coin)
          PresentedRecord.create(user_id: user.id,number: coin,reason: "邀请YBZ会员#{number}位",is_effective:1,type:"Available",wight: 15,balance: coin)
          user.ybz_number = 0
          user.save
        end
      elsif number >= 6
        coin = number * 25000 * 0.2
        if integral.update(available: integral.available + coin,exchange: integral.exchange + coin,not_appreciation: integral.not_appreciation + coin)
          PresentedRecord.create(user_id: user.id,number: coin,reason: "邀请YBZ会员#{number}位",is_effective:1,type:"Available",wight: 15,balance: coin)
          user.ybz_number = 0
          user.save
        end
      end
    end
    puts "定时器结束，当前时间#{Time.current}"
  end
end
