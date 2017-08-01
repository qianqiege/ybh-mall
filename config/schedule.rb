# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
log_path = ::File.expand_path('../../log/cron_log.log', __FILE__)
FileUtils.touch log_path unless File.exist? log_path
set :output, log_path

every 1.day, :at => '4:30 am' do
  rake 'users:update_coin'
end

every 1.day, :at => '4:00 am' do
  rake 'presented_record:update_locking_available'
end

every 1.day, :at => '3:30 am' do
  rake 'order:update_status'
end

every '0 0 1 * *' do
  rake 'ybz_vip:reward'
end

every 1.day, :at => '3:00 am' do
  rake 'data:date_ycoin'
end
