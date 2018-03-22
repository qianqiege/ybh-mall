require "json"

class API::V1::Code < API

  namespace :code, desc: '二维码' do

    desc '二维码'
    params do
      requires :user_id, type: Integer
      requires :code_id, type: Integer
    end

    get 'invitation_code' do
      # 注册邀请码
      user = User.find(params[:user_id])
    end

    get 'health_code' do
      # 健康检测码
    end

    get 'activity_code' do
      # 活动推广码
    end

    post 'create_activity_code' do
      # 申请活动二维码
    end

    post 'update_activity_code' do
      # 更新活动二维码 用于管理员审批二维码
    end

    get 'all_activity_code' do
      # 活动二维码审核功能 查出所有二维码
    end

    desc '小程序二维码'
    params do
      requires :get_price, type: String
    end 
    get 'get_rcode' do

      
      # 获取access_token值；
      access_token = RestClient.get('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxfba7e4bb0c78fb0a&secret=42a0f6c087e22923fca1579d066dd118')
      token = JSON.parse(access_token)

      # 获取二维码
      data = {"scene": params[:get_price]}.to_json
      url = 'https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token='+ token["access_token"]
      
      path = File.join Rails.root, 'app', 'assets', 'images', 'rcode'
      FileUtils.mkdir_p(path) unless File.exist?(path)
      num = rand(0xffffff)
      File.open(File.join(path, "rcode_img_#{num}.jpeg"), 'w'){ |f|
        block = proc { |response|
          response.read_body do |chunk|
            chunk.force_encoding('utf-8') 
            puts "二维码生成"
            f.write chunk
          end
        }
        RestClient::Request.new(method: :post, url: url, payload: data, block_response: block).execute

      }

      return "http://192.168.1.235:3000/assets/rcode/rcode_img_#{num}.jpeg"
      

    end 
  end

end
