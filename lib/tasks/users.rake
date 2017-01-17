namespace :users do
  desc "update coin of each users"
  task update_coin: :environment do
    puts "定时器启动，当前时间为#{Time.current}"
    ScoinAccount.where.not(number:nil).each do |account|
      puts "开始更新 #{account.account} S币,更新前S币数量为#{account.number}"
      account.calculate_number
      puts "更新成功，更新后S币数量为#{account.number}"
    end
    puts "定时器结束，当前时间为#{Time.current}"
  end
end
