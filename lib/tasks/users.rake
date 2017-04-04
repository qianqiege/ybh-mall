namespace :users do
  desc "update coin of each users"
  task update_coin: :environment do
    puts "定时器启动，当前时间为#{Time.current}"

    ScoinAccount.where.not(number:nil).each do |account|
      puts "开始更新 #{account.account} S货币,更新前S货币数量为#{account.number}"
      account.calculate_number
      puts "更新成功，更新后S货币数量为#{account.number}"
    end

    YcoinRecord.includes(:coin_type).ongoing.each do |record|
      current_time = Time.current.strftime('%Y-%m-%d %H:%M:%S')
      record.account.presented_records.create(user_id: record.account_id, number: record.coin_type.everyday, reason: "每天赠送,时间：#{current_time}")
    end

    puts "定时器结束，当前时间为#{Time.current}"
  end
end
