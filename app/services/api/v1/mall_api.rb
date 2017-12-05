class API::V1::MallApi < API
    format :json
    namespace :shop_mall, desc: "商城相关" do
        desc "获取分类",
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          {
            "sort_id": 1,
            "sort": "销售产品",
          }
          ```
        NOTES
        get 'sort' do
            [
                {sort_id:"1", sort:"销售产品"},
                {sort_id:"2", sort:"活动产品"},
                {sort_id:"3", sort:"虚拟产品"},
                {sort_id:"4", sort:"点亮心灯"}
            ]
        end

        desc "获取分类产品",
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          [
              1（产品id）,
              "甘净"（产品名称）,
              "960"（产品价格）,
              "1.jpg"（产品图片）
          ]
          ```
          > 请求失败返回信息

          ```json
            "该分类暂无产品！"
          ```
        NOTES
        params do
            requires :sort, type:Integer
        end
        get 'sort_product' do
            t = Product.where(sort:params[:sort]).pluck(:id, :name, :now_product_price, :image)
            if t.blank?
                return "该分类暂无产品！"
            else
                return t
            end
        end

        desc "获取全部产品",
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          [
              1（产品id）,
              "甘净"（产品名称）,
              "960"（产品价格）,
              "1.jpg"（产品图片）
          ]
          ```
        NOTES
        get 'all_product' do
            Product.where(display:true).pluck(:id, :image, :name, :now_product_price)
        end


        desc "获取产品详情",
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            [
                1（产品id）,
                "1-4.jpg"（产品图片）,
                "YBZ会员"（产品名称）,
                "12000.0"（产品价格）,
                "12000"（产品规格）,
                "xxx"（包装）,
                "某某厂家"（生产厂家）,
                "<p style=\"text-align: justify;\">......（产品描述）"
            ]
          ```
          > 请求失败返回信息

          ```json
            "该产品ID有误！"
          ```
        NOTES
        params do
            requires :product_id, type:Integer
        end
        get 'product' do
            t = Product.where(id:params[:product_id]).pluck(:id, :image, :name, :now_product_price, :spec, :packaging, :production, :desc)
            if t.blank?
                return "该产品ID有误！"
            else
                return t
            end
        end

        desc "获取购物车产品",
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          {
              "id": 233,
              "product_id": 4,
              "cart_id": 51,
              "quantity": 1,
              "order_id": null,
              "in_cart": true,
              "unit_price": null
          }
          ```
          > 请求失败返回信息

          ```json
            "该用户购物车为空！"
          ```
        NOTES
        params do
            requires :user_id, type:Integer
        end
        get 'cart_product' do
            t = User.find_by(id:params[:user_id]).cart.line_items.where(in_cart:true)
            if t.blank?
                return "该用户购物车为空！"
            else
                return t
            end
        end

        desc '删除购物车产品',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            "删除成功！"
          ```
          > 请求失败返回信息

          ```json
           "删除失败！"
          ```
        NOTES
        params do
            requires :user_id,      type:Integer
            requires :product_id,   type:Integer
        end
        delete 'delete_cart_product' do
            t = User.find_by(id:params[:user_id]).cart.line_items.where(product_id:params[:product_id])
            if t.destroy
                return "删除成功！"
            else
                return "删除失败！"
            end
        end

        desc '编辑产品',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          {
              "id": 233,
              "product_id": 4,
              "cart_id": 51,
              "quantity": 1,
              "order_id": null,
              "in_cart": true,
              "unit_price": null
          }
          ```
          > 请求失败返回信息

          ```json
            "保存失败！"
          ```
        NOTES
        params do
            requires :user_id,      type:Integer
            requires :product_id,   type:Integer
            requires :quantity,     type:Integer
        end
        put 'edit_cart_product' do
            t = User.find_by(id:params[:user_id]).cart.line_items.find_by(product_id:params[:product_id])
            t.quantity = params[:quantity]
            if t.save
                return t
            else
                return "保存失败！"
            end
        end

        desc '加入购物车',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            已加入购物车！
          ```
          > 请求失败返回信息

          ```json
            "加入购物车失败"
          ```
        NOTES
        params do
            requires :user_id,      type:Integer
            requires :product_id,   type:Integer
        end
        post 'add_cart' do
            if User.find_by(id:params[:user_id]).cart.line_items.find_by(product_id:params[:product_id]) == nil
                t = LineItem.new(   cart_id:    User.find_by(id:params[:user_id]).cart.id,
                                product_id: params[:product_id],
                                quantity:   1)
                if t.save
                    "已加入购物车！"
                else
                    "加入购物车失败！"
                end
            else
                t = User.find_by(id:params[:user_id]).cart.line_items.find_by(product_id:params[:product_id])
                t.quantity += 1
                if t.save
                    "已加入购物车！"
                else
                    "加入购物车失败！"
                end
            end
        end

        desc '活动',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            [
                1,
                "管理健康创造财富-YBS"
            ]
          ```
        NOTES
        get 'activity' do
            Activity.where(is_show:true).pluck(:id, :name)
        end

        desc '支付方式',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          {
              "id": 1,
              "value": "微信支付"
          }
          ```
        NOTES
        get 'pay_type' do
            [   {id:1, value:"微信支付"},
                {id:2, value:"银行卡支付"},
                {id:3, value:"线下支付"}
            ]
        end

        # all:"全部订单", pending: '待付款', wait_send: '待发货', wait_confirm: '待收货', cancel: '已取消', received: '已收货' ,return_change: '退货/款'
        desc '获取订单',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          {
            "status": "cancel",
            "id": 908,
            "number": "20170718151710950912",
            "integral": "0.0",
            "price": "3360.0",
            "total_quantity": 3,
            "address": {
                "contact_name": "张三",
                "mobile": "18025340000",
                "province": "440000",
                "city": "440300",
                "street": "440305",
                "detail": "国际国际"
            },
            "item": [
                {
                    "image": {
                        "image": {
                            "url": "/uploads/product/image/4/__C_.png",
                            "thumb": {
                                "url": "/uploads/product/image/4/thumb___C_.png"
                            },
                            "icon": {
                                "url": "/uploads/product/image/4/icon___C_.png"
                            },
                            "product_icon": {
                                "url": "/uploads/product/image/4/product_icon___C_.png"
                            }
                        }
                    },
                    "name": "御邦C筑",
                    "now_product_price": "1120.0",
                    "quantity": 3
                }
            ]
        }
          ```
          > 请求失败返回信息

          ```json
          "该用户还未创建订单！"
          ```
        NOTES
        params do
            requires :user_id,  type:Integer
            requires :type,     type:String
        end
        get 'orders' do
            arr=[]
            if params[:type] == "all"
                Order.where(user_id:params[:user_id]).each do |h|
                    object          = {}
                    address_object  = {}
                    item            = []
                    # 获取地址放入地址对象中
                    a = Address.find_by(id:h.address_id)
                    address_object["contact_name"]  = a.contact_name
                    address_object["mobile"]        = a.mobile
                    address_object["province"]      = a.province
                    address_object["city"]          = a.city
                    address_object["street"]        = a.street
                    address_object["detail"]        = a.detail
                    # 获取详单信息放入详单数组中
                    quantity = 0
                    LineItem.where(order_id:h.id).each do |f|
                        item_object = {}
                        t = Product.find_by(id:f.product_id)
                        item_object["image"]                = t.image
                        item_object["name"]                 = t.name
                        item_object["now_product_price"]    = t.now_product_price
                        item_object["quantity"]             = f.quantity
                        item.push(item_object)
                        quantity += f.quantity
                    end
                    # 将订单信息放入订单对象中
                    object["status"]            = h.status
                    object["id"]                = h.id
                    object["number"]            = h.number
                    object["integral"]          = h.integral
                    object["price"]             = h.price
                    object["total_quantity"]    = quantity
                    object["address"]           = address_object
                    object["item"]              = item
                    arr.push(object)
                end
            else
                Order.where(user_id:params[:user_id], status:params[:type]).each do |h|
                    object          = {}
                    address_object  = {}
                    item            = []
                    # 获取地址放入地址对象中
                    a = Address.find_by(id:h.address_id)
                    address_object["contact_name"]  = a.contact_name
                    address_object["mobile"]        = a.mobile
                    address_object["province"]      = a.province
                    address_object["city"]          = a.city
                    address_object["street"]        = a.street
                    address_object["detail"]        = a.detail
                    # 获取详单信息放入详单数组中
                    quantity = 0
                    LineItem.where(order_id:h.id).each do |f|
                        item_object = {}
                        t = Product.find_by(id:f.product_id)
                        item_object["image"]                = t.image
                        item_object["name"]                 = t.name
                        item_object["now_product_price"]    = t.now_product_price
                        item_object["quantity"]             = f.quantity
                        item.push(item_object)
                        quantity += f.quantity
                    end
                    # 将订单信息放入订单对象中
                    object["status"]            = h.status
                    object["id"]                = h.id
                    object["number"]            = h.number
                    object["integral"]          = h.integral
                    object["price"]             = h.price
                    object["total_quantity"]    = quantity
                    object["address"]           = address_object
                    object["item"]              = item
                    arr.push(object)
                end
            end
            if arr.blank?
                return "该用户还未创建订单！"
            else
                return arr
            end
        end

        desc '新增收货地址',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          {
                "id": 17,
                "contact_name": "张三",
                "mobile": "18025340000",
                "is_default": false,
                "detail": "TCL",
                "province": "440000",
                "city": "440300",
                "street": "440305",
                "wechat_user_id": null,
                "created_at": "2017-01-22T15:09:15.000+08:00",
                "updated_at": "2017-11-30T10:37:58.000+08:00",
                "user_id": 1
          }
          ```
          > 请求失败返回信息

          ```json
          "地址保存失败！"
          ```
        NOTES
        params do
            requires :contact_name, type:String
            requires :user_id,      type:Integer
            requires :mobile,       type:String
            requires :province,     type:String
            requires :city,         type:String
            requires :street,       type:String
            requires :detail,       type:String
        end
        post 'create_address' do
            t = Address.new( user_id:        params[:user_id],
                            contact_name:   params[:contact_name],
                            mobile:         params[:mobile],
                            province:       params[:province],
                            city:           params[:city],
                            street:         params[:city],
                            detail:         params[:detail]
                            )
            if t.save
                return t
            else
                return "地址保存失败！"
            end
        end

        desc '获取全部地址',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            [
                "张三"（联系人）,
                "18025340000"（电话）,
                false（是否为默认地址）,
                "440000"（省）,
                "440300"（城市）,
                "440305"（街道）,
                "TCL"（详细信息）,
                17（地址id）
            ]
          ```
          > 请求失败返回信息

          ```json
            "该用户还未创建地址！"
          ```
        NOTES
        params do
            requires :user_id, type:Integer
        end
        get 'get_address' do
            t = Address.where(user_id:params[:user_id]).pluck(:contact_name, :mobile, :is_default, :province, :city, :street, :detail, :id)
            if t.blank?
                return "该用户还未创建地址！"
            else
                return t
            end
        end

        desc '设为默认地址',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            "设置成功！"
          ```
          > 请求失败返回信息

          ```json
            "设置失败！"
          ```
        NOTES
        params do
            requires :address_id, type:Integer
        end
        put "set_default_address" do
            t = Address.find_by(id:params[:address_id])
            f = Address.find_by(user_id:t.user_id, is_default:true)
            if f != nil
                f.is_default = false
                f.save
            end
            t.is_default = true
            if t.save
                return "设置成功！"
            else
                return "设置失败！"
            end
        end

        desc '获取默认地址',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
          {
                "id": 17,
                "contact_name": "张三",
                "mobile": "18025340000",
                "is_default": true,
                "detail": "TCL",
                "province": "440000",
                "city": "440300",
                "street": "440305",
                "wechat_user_id": null,
                "created_at": "2017-01-22T15:09:15.000+08:00",
                "updated_at": "2017-11-30T10:37:58.000+08:00",
                "user_id": 1
          }
          ```
          > 请求失败返回结果

          ```json
            "该用户无默认地址！"
          ```
        NOTES
        params do
            requires :user_id, type:Integer
        end
        get "get_default_address" do
            t = Address.find_by(user_id:params[:user_id], is_default:true)
            if t.blank?
                return "该用户无默认地址！"
            else
                return t
            end
        end

        desc '获取热卖产品',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            [
                42（产品id）,
                "自定义产品消费"（产品名称）,
                "__icon.png"（产品图片）,
                "1.0"（产品价格）
            ]
          ```
        NOTES
        get 'hot_product' do
            arr = []
            Product.where(display:true).each do |t|
                object = {}
                brr = LineItem.where(product_id:t.id, in_cart:false).pluck(:quantity)
                quantity = 0
                brr.each do |b|
                    quantity += b
                end
                object[:product_id] = t.id
                object[:quantity] = quantity
                arr.push(object)
            end
            object_arr = arr.sort_by{|u| u[:quantity]}
            crr = []
            l = arr.length
            i = l-1
            while i>l-9 do
                crr.push(object_arr[i])
                i -= 1
            end
            data = []
            crr.each do |d|
                t = Product.where(id:d[:product_id]).pluck(:id, :name, :image, :now_product_price)
                data.push(t[0])
            end
            return data
        end

        desc '获取活动及对应产品',
        detail: <<-NOTES.strip_heredoc
          > 请求成功返回信息

          ```json
            {
                "activety_image": {
                    "image": {
                        "url": "/uploads/activity/image/1/5358ca76a5050.jpg",
                        "thumb": {
                            "url": "/uploads/activity/image/1/thumb_5358ca76a5050.jpg"
                        },
                        "icon": {
                            "url": "/uploads/activity/image/1/icon_5358ca76a5050.jpg"
                        },
                        "product_icon": {
                            "url": "/uploads/activity/image/1/product_icon_5358ca76a5050.jpg"
                        }
                    }
                },
                "product": [
                    [
                        49（产品id）,
                        "御邦C筑"（产品名称）,
                        "5358ca76a5050.jpg"（产品图片）,
                        "560.0"（产品价格）
                    ],
                    [
                        56,
                        "点亮心灯-功能强化调理方案",
                        "1.jpg",
                        "1870.0"
                    ]
                ]
            }
            > 请求失败返回信息

            ```json
              "找不到该活动！"
              "该活动暂无产品！"
            ```
          ```
        NOTES
        params do
            requires :activity_id, type:Integer
        end
        get 'activity_product' do
            object = {}
            t = Activity.find_by(id:params[:activity_id], is_show:true)
            f = Product.where(activity_id: params[:activity_id], display:true).pluck(:id, :name, :image, :now_product_price)
            object[:activety_image] = t.image
            object[:product] = f
            if t.blank?
                return "找不到该活动！"
            else
                if f.blank?
                    return "该活动暂无产品！"
                else
                    return object
                end
            end
        end
    end
end
