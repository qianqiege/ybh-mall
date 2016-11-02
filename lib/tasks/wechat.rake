namespace :wechat do
  desc "generate wechat DIY menu"
  task generate_menu: :environment do
    client = $wechat_client
    puts "delete old menu"
    client.delete_menu

    puts "generate started"
    client.create_menu Settings.weixin.menu
    puts "generate ended"
  end
end
