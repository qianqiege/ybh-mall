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

every 1.day, :at => '12:00 pm' do
  rake 'presented_record:update_available_y'
  rake 'coin:update_coin_type_level_type'
end
