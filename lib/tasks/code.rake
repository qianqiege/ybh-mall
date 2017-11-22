namespace :code do
  desc "update code pending to void"
  task update_code_state: :environment do
    puts "定时器启动，当前时间为#{Time.current}"
    ApplyCode.where(state: "available").each do |code|
      @time = (Date.current - Date.parse(code.created_at.to_s)).to_f
      if @time >= 1.5
        code.state = "viod"
        code.save
      end
    end
    puts "定时器结束，当前时间为#{Time.current}"
  end
end
