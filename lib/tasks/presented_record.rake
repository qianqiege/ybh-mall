namespace :presented_record do
  desc "update available_y of users"
  task update_available_y: :environment do
    puts "定时器启动，当前时间为#{Time.current}"

    # 查询有效的记录
    PresentedRecord.where(is_effective: 1).each do |record|
      # 计算当前时间与记录创建时间 有多少天
      @time = (Date.current - Date.parse(record.created_at.to_s)).to_i
      # 判断天数是否大于90天
      if @time >= 90
        # 在User表中找到这条记录的 用户
        @user = User.find_by(id: record.user_id)
        # 判断 是否找到用户 并且 经计算记录的易积分数量是否是正值
        if !@user.nil? && record.number > 0
          # 条件为true,执行计算，从锁定积分中减掉，加到可用积分
          locking_y = @user.locking_y.to_i - record.number
          available_y = @user.available_y.to_i + record.number
          # 更新用户的锁定积分和可用积分
          if @user.update(locking_y: locking_y,available_y: available_y)
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

            # 将刚刚从锁定易积分中减掉的积分 加到可用易积分中
            PresentedRecord.create(user_id: record.user_id,
                                  number: record.number,
                                  reason: "接受变更可兑换积分",
                                  is_effective:0,
                                  type:"Available")
          end
        end
      end
    end
    puts "定时器结束，当前时间为#{Time.current}"
  end
end
