namespace :ybz_vip do
  desc "reward user"
  task reward: :environment do
    puts "定时器启动，当前时间#{Time.current}"

    @user = User.all
    @user.each do |user|
      @integral = Integral.find_by(user_id: user.id)
      number = user.ybz_number

      if number > 0 && number <= 5
        @coin = number * 25000 * 0.1
        @record = PresentedRecord.new(user_id: user.id,number: @coin,reason: "邀请YBZ会员#{number}位",is_effective:1,type:"Available",wight: 15,balance: @coin)
      elsif number >= 6
        @coin = number * 25000 * 0.2
        @record = PresentedRecord.new(user_id: user.id,number: @coin,reason: "邀请YBZ会员#{number}位",is_effective:1,type:"Available",wight: 15,balance: @coin)
      end
      user.ybz_number = 0
      user.save
    end

    if @record.save
      @integral.update(available: @integral.available + @coin,exchange: @integral.exchange + @coin,not_appreciation: @integral.not_appreciation + @coin)
    end

    puts "定时器结束，当前时间#{Time.current}"
  end
end
