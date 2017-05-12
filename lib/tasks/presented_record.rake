namespace :presented_record do
  desc "update locking to available of users"
  task update_locking_available: :environment do
    puts "定时器启动，当前时间为#{Time.current}"

    # 查询有效的记录
    PresentedRecord.where(is_effective: 1).each do |record|
      # 计算当前时间与记录创建时间 有多少天
      @time = (Date.current - Date.parse(record.created_at.to_s)).to_i

      # 每笔入账积分为锁定积分 15天后可用
      fifteen_days = 15
      # 积分满六个月180天 可以兑换体现 升值5%
      sex_months = 180

      case record.type
      when "Locking"
        # 锁定变更 可用

        # 判断天数是否大于fifteen_days天
        if @time >= fifteen_days && record.wight == 1
          @integral = Integral.find_by(user_id: record.user_id)
          # 判断 是否找到用户 并且 经计算记录的易积分数量是否是正值
          if !@integral.nil? && record.balance > 0 && @integral.locking >= record.balance
            # 条件为true,执行计算，从锁定积分中减掉，加到可用积分
             locking = @integral.locking - record.balance
             # 更新用户的锁定积分和可用积分
             if @integral.update(locking: locking)
               puts "更新锁定积分总数为#{locking}"
               # 更新成功后，将这条记录判定为无效记录，避免重复计算
               record.is_effective = 0
               # 将修改保存到数据库
               record.save
               # 将满足fifteen_days天的易积分从 锁定易积分中减掉
               PresentedRecord.create(user_id: record.user_id,
                                     number: "-#{record.balance}",
                                     reason: "锁定变更可用积分",
                                     is_effective:0,
                                     type:"Locking",
                                     wight: record.wight)
               puts "生成易积分收支记录，锁定易积分中减#{record.balance}"

               # 将刚刚从锁定易积分中减掉的积分 加到可兑易积分中
               PresentedRecord.create(user_id: record.user_id,
                                     number: record.balance,
                                     reason: "接受变更可用积分",
                                     is_effective:1,
                                     type:"Available",
                                     wight: record.wight)

               puts "生成易积分收支记录，可用积分中加#{record.balance}"
             end
          end
        end
      when "Available"

        # 判断天数是否大于sex_months天
        if @time >= sex_months && record.wight == 1
          @integral = Integral.find_by(user_id: record.user_id)
          # 判断 是否找到用户 并且 经计算记录的易积分数量是否是正值
          if !@integral.nil? && record.balance > 0 && @integral.available >= record.balance
            # 条件为true,执行计算，从可用积分中减掉，加到可兑换积分
             available = @integral.available - record.balance
             exchange = @integral.exchange + record.balance

             # 更新成功后，将这条记录判定为无效记录，避免重复计算
             record.is_effective = 0
             # 将修改保存到数据库
             record.save

             # 将满足sex_months天的易积分从 锁定易积分中减掉
             PresentedRecord.create(user_id: record.user_id,
                                   number: "-#{record.balance}",
                                   reason: "可用积分变更可兑积分",
                                   is_effective:0,
                                   type:"Available",
                                   wight: record.wight)
             puts "生成易积分收支记录，锁定易积分中减#{record.balance}"

             # 将刚刚从锁定易积分中减掉的积分 加到可兑易积分中
             PresentedRecord.create(user_id: record.user_id,
                                   number: record.balance,
                                   reason: "接受变更可兑积分",
                                   is_effective:1,
                                   type:"Exchange",
                                   wight: record.wight)

             puts "生成易积分收支记录，可兑积分中加#{record.balance}"

             @integral.update(exchange: @integral.not_exchange + record.balance,not_exchange: @integral.not_exchange - record.balance)
          end
        end
      end

    end
    puts "定时器结束，当前时间为#{Time.current}"
  end
end
