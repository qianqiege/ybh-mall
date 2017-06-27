namespace :order do
  desc "update locking to available of users"
  task update_status: :environment do
    puts "定时器启动，当前时间#{Time.current}"

    Order.where(status: "wait_confirm").each do |order|
      @time = (Date.current - Date.parse(order.created_at.to_s)).to_i

      if @time >= 15
        order.status = "received"
        order.save
        puts "变更订单状态(代收货->已收货)，订单ID为#{order.id}，订单用户#{order.user_id}"
      end
    end

    Order.where(status: "pending").each do |order|
      @time = (Date.current - Date.parse(order.created_at.to_s)).to_i

      if @time >= 3
        order.status = "cancel"
        order.save
        puts "变更订单状态 (代付款->已取消)，订单ID为#{order.id}，订单用户#{order.user_id}"
      end
    end

    puts "定时器结束，当前时间为#{Time.current}"
  end
end
