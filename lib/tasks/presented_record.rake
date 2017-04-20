namespace :presented_record do
  desc "update available_y of users"
  task update_available_y: :environment do
    puts "定时器启动，当前时间为#{Time.current}"

    # 查询有效的记录
    PresentedRecord.where(is_effective: 1).each do |record|
      # 计算当前时间与记录创建时间 有多少天
      @time = (Date.current - Date.parse(record.created_at.to_s)).to_i
      case record.type

      when "Locking"
        # 判断天数是否大于90天
        if @time >= 90
          # 在User表中找到这条记录的 用户
          @integral = Integral.find_by(user_id: record.user_id)
          # 判断 是否找到用户 并且 经计算记录的易积分数量是否是正值
          if !@integral.nil? && record.number > 0 && @integral.locking >= record.number
            # 条件为true,执行计算，从锁定积分中减掉，加到可用积分
            locking = @integral.locking - record.number
            bronze = @integral.bronze + record.number
            # 更新用户的锁定积分和可用积分
            if @integral.update(locking: locking,bronze: bronze)
              puts "更新锁定积分总数为#{locking}"
              puts "更新青铜积分总数为#{bronze}"
              # 计算所有可兑换的积分总数
              count = @integral.bronze + @integral.silver + @integral.gold
              # 更新可兑换积分总数
              @integral.update(available: count)
              puts "更新可兑换积分总数为#{count}"
              # 更新成功后，将这条记录判定为无效记录，避免重复计算
              record.is_effective = 0
              # 将修改保存到数据库
              record.save
              # 将满足90天的易积分从 锁定易积分中减掉
              PresentedRecord.create(user_id: record.user_id,
                                    number: "-#{record.number}",
                                    reason: "锁定变更可兑换积分",
                                    is_effective:0,
                                    type:"Locking")
              puts "生成易积分收支记录，锁定易积分中减#{record.number}"

              # 将刚刚从锁定易积分中减掉的积分 加到可用易积分中
              PresentedRecord.create(user_id: record.user_id,
                                    number: record.number,
                                    reason: "接受变更可兑换积分(青铜积分)",
                                    is_effective:1,
                                    type:"Bronze")

              puts "生成易积分收支记录，青铜积分中加#{record.number}"
            end
          end
        end

      when "Bronze"
        # 判断天数是否大于180天
        if @time >= 180
          # 在User表中找到这条记录的 用户
          @integral = Integral.find_by(user_id: record.user_id)
          # 判断 是否找到用户 并且 经计算记录的易积分数量是否是正值
          if !@integral.nil? && record.number > 0 && @integral.bronze >= record.number
            # 条件为true,执行计算，从青铜积分中减掉，加到白银积分
            bronze = @integral.bronze - record.number
            silver = @integral.silver + record.number
            # 更新用户的青铜积分和白银积分
            if @integral.update(bronze: bronze,silver: silver)
              puts "更新青铜积分总数为#{bronze}"
              puts "更新白银积分总数为#{silver}"
              # 计算所有可兑换的积分总数
              count = @integral.bronze + @integral.silver + @integral.gold
              # 更新可兑换积分总数
              @integral.update(available: count)
              puts "更新可兑换积分总数为#{count}"
              # 更新成功后，将这条记录判定为无效记录，避免重复计算
              record.is_effective = 0
              # 将修改保存到数据库
              record.save
              # 将满足180天的易积分从 青铜积分中减掉
              PresentedRecord.create(user_id: record.user_id,
                                    number: "-#{record.number}",
                                    reason: "青铜积分变更白银积分",
                                    is_effective:0,
                                    type:"Bronze")
              puts "生成易积分收支记录，青铜易积分中减#{record.number}"

              # 将刚刚从黄铜易积分中减掉的积分 加到白银易积分中
              PresentedRecord.create(user_id: record.user_id,
                                    number: record.number,
                                    reason: "接受变更可兑换积分(白银积分)",
                                    is_effective:1,
                                    type:"Silver")

              puts "生成易积分收支记录，白银积分中加#{record.number}"
            end
          end
        end

      when "Silver"
        # 判断天数是否大于270天
        if @time >= 270
          # 在User表中找到这条记录的 用户
          @integral = Integral.find_by(user_id: record.user_id)
          # 判断 是否找到用户 并且 经计算记录的易积分数量是否是正值
          if !@integral.nil? && record.number > 0 && @integral.silver >= record.number
            # 条件为true,执行计算，从白银积分中减掉，加到黄金积分
            silver = @integral.silver - record.number
            gold = @integral.gold + record.number
            # 更新用户的白银积分和黄金积分
            if @integral.update(gold: gold,silver: silver)
              puts "更新白银积分总数为#{silver}"
              puts "更新黄金积分总数为#{gold}"
              # 计算所有可兑换的积分总数
              count = @integral.bronze + @integral.silver + @integral.gold
              # 更新可兑换积分总数
              @integral.update(available: count)
              puts "更新可兑换积分总数为#{count}"
              # 更新成功后，将这条记录判定为无效记录，避免重复计算
              record.is_effective = 0
              # 将修改保存到数据库
              record.save
              # 将满足270天的易积分从 白银易积分中减掉
              PresentedRecord.create(user_id: record.user_id,
                                    number: "-#{record.number}",
                                    reason: "白银积分变更黄金积分",
                                    is_effective:0,
                                    type:"Silver")
              puts "生成易积分收支记录，白银易积分中减#{record.number}"

              # 将刚刚从白银积分中减掉的积分 加到黄金易积分中
              PresentedRecord.create(user_id: record.user_id,
                                    number: record.number,
                                    reason: "接受变更可兑换积分(黄金积分)",
                                    is_effective:1,
                                    type:"Gold")

              puts "生成易积分收支记录，黄金积分中加#{record.number}"
            end
          end
        end

      end
    end
    puts "定时器结束，当前时间为#{Time.current}"
  end
end
