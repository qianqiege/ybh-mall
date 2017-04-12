namespace :presented_record do
  desc "update available_y of users"
  task update_available_y: :environment do
    puts "定时器启动，当前时间为#{Time.current}"

    PresentedRecord.where(is_effective: 1).each do |record|
      @time = (Date.current - Date.parse(record.created_at.to_s)).to_i
      if @time >= 90
        @user = User.find_by(id: record.user_id)
        if !@user.nil?
          locking_y = @user.locking_y.to_i - record.number
          available_y = @user.available_y.to_i + record.number
          if @user.update(locking_y: locking_y,available_y: available_y)
            record.is_effective = 0
            record.save
          end
        end
      end
    end
    puts "定时器结束，当前时间为#{Time.current}"
  end
end
