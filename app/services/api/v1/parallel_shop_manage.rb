class API::V1::ParallelShopManage < API 

	namespace :parallel_shop_manage, desc: '影子店管理' do 
		desc '判断有没有影子店', detail: <<-NOTES.strip_heredoc
		> 请求成功返回信息

		```json
		{ "status": 1 }
		```

		> 请求失败的返回信息

		```json
    {
      "error_message": "未知错误",
      "error_code": 401
    }

    ```

		>请求成功之后的状态信息
		```json
		{
		"status": "1（表示有影子店）",
		"status": "2（表示没有影子店）",
		}
		```
		NOTES
		params do 
			requires :id, type: Integer 
		end

		get "user_info" do 
			user = User.find(params[:id])
			if user.parallel_shop_id?
				return { "status": 1 }
			else
				return { "status": -1 }
			end
		end

	end

end