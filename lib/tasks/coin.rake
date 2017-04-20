namespace :coin do
  desc "update_coin_type_level_type"
  task update_coin_type_level_type: :environment do
    puts "定时器启动，当前时间为#{Time.current}"

    CoinRecord.where(type:"YcoinRecord").each do |record|
      @time = (Date.current - Date.parse(record.created_at.to_s)).to_i
      ap record
      ap @time
      case record.level_type
      when ""
        record.level_type = "Locking"
        record.save
      when "Locking"
        if @time >= 90
          record.level_type = "Bronze"
          record.save
        end
      when "Bronze"
        if @time >= 180
          record.level_type = "Silver"
          record.save
        end
      when "Silver"
        if @time >= 270
          record.level_type = "Gold"
          record.save
        end
      end
    end

    puts "定时器结束，当前时间为#{Time.current}"
  end
end
