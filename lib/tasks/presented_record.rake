namespace :presented_record do
  desc "update locking to available of users"
  task update_locking_available: :environment do
    puts "定时器启动，当前时间#{Time.current}"

    # 查询有效的记录
    PresentedRecord.where(is_effective: 1).each do |record|
      # 计算当前时间与记录创建时间 有多少天
      @time = (Date.current - Date.parse(record.created_at.to_s)).to_i

      # 每笔入账积分为锁定积分 15天后可用 （2017/09/16号变更为3天）
      fifteen_days = 3
      # 积分满六个月180天 可以兑换体现 升值5% (2017/11/11号变更为3天)
      # sex_months = 3

      case record.type
      when "Locking"
        # 判断天数是否大于fifteen_days天
        if @time >= fifteen_days && record.wight == 1
          @integral = Integral.find_by(user_id: record.user_id)
          # 判断 是否找到用户 并且 经计算记录的易积分数量是否是正值

          if !@integral.nil? && !record.balance.nil?
            # 条件为true,执行计算，从锁定积分中减掉，加到可用积分
             locking = @integral.locking - record.balance
             available = @integral.available + record.balance
             # 更新用户的锁定积分和可用积分
             if @integral.update(locking: locking,available: available)
               puts "更新锁定积分总数为#{locking}"
               # 将刚刚从锁定易积分中减掉的积分 加到可兑易积分中
               record.update(type:"Available")
               # 将修改保存到数据库
               record.save
             end
          end
        end

      end
    end
    puts "定时器结束，当前时间为#{Time.current}"
  end
end
