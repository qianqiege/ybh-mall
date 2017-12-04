class API::V1::MallApi < API
    format :json
    namespace :mall, desc: "商城相关" do
        desc '分类'
        get 'sort' do
            [
                {sort_id:"1", sort:"销售产品"},
                {sort_id:"2", sort:"活动产品"},
                {sort_id:"3", sort:"虚拟产品"},
                {sort_id:"4", sort:"点亮心灯"}
            ]
        end

        desc '分类产品'
        params do
            requires :sort, type:Integer
        end
        get 'sort_product' do
            Product.where(sort:params[:sort]).pluck(:id, :name, :now_product_price, :image)
        end

        desc "全部产品"
        get 'all_product' do
            Product.where(display:true).pluck(:id, :image, :name, :now_product_price)
        end


        desc '产品详情'
        params do
            requires :product_id, type:Integer
        end
        get 'product' do
            Product.where(id:params[:product_id]).pluck(:id, :image, :name, :now_product_price, :spec, :packaging, :production, :desc)
        end

        desc '购物车产品'
        params do
            requires :user_id, type:Integer
        end
        get 'cart_product' do
            User.find_by(id:params[:user_id]).cart.line_items.where(in_cart:true)
        end

        desc '删除购物车产品'
        params do
            requires :user_id,      type:Integer
            requires :product_id,   type:Integer
        end
        delete 'delete_cart_product' do
            User.find_by(id:params[:user_id]).cart.line_items.where(product_id:params[:product_id]).destroy
        end

        desc '编辑产品'
        params do
            requires :user_id,      type:Integer
            requires :product_id,   type:Integer
            requires :quantity,     type:Integer
        end
        put 'edit_cart_product' do
            t = User.find_by(id:params[:user_id]).cart.line_items.find_by(product_id:params[:product_id])
            t.quantity = params[:quantity]
            t.save
        end

        desc '加入购物车'
        params do
            requires :user_id,      type:Integer
            requires :product_id,   type:Integer
        end
        post 'add_cart' do
            if User.find_by(id:params[:user_id]).cart.line_items.find_by(product_id:params[:product_id]) == nil
                LineItem.create(cart_id:    User.find_by(id:params[:user_id]).cart.id,
                                product_id: params[:product_id],
                                quantity:   1)
            else
                t = User.find_by(id:params[:user_id]).cart.line_items.find_by(product_id:params[:product_id])
                t.quantity += 1
                t.save
            end
        end

        desc '活动'
        get 'activity' do
            Activity.where(is_show:true).pluck(:id, :name)
        end

        desc '支付方式'
        get 'pay_type' do
            [   {id:1, value:"微信支付"},
                {id:2, value:"银行卡支付"},
                {id:3, value:"线下支付"}
            ]
        end

        # all:"全部订单", pending: '待付款', wait_send: '待发货', wait_confirm: '待收货', cancel: '已取消', received: '已收货' ,return_change: '退货/款'
        desc '获取订单'
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
            return arr
        end

        desc '新增收货地址'
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
            Address.create( user_id:        params[:user_id],
                            contact_name:   params[:contact_name],
                            mobile:         params[:mobile],
                            province:       params[:province],
                            city:           params[:city],
                            street:         params[:city],
                            detail:         params[:detail]
                            )
        end

        desc '获取全部地址'
        params do
            requires :user_id, type:Integer
        end
        get 'get_address' do
            Address.where(user_id:params[:user_id]).pluck(:contact_name, :mobile, :is_default, :province, :city, :street, :detail, :id)
        end

        desc '设为默认地址'
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
            t.save
        end

        desc '获取默认地址'
        params do
            requires :user_id, type:Integer
        end
        get "get_default_address" do
            Address.find_by(user_id:params[:user_id], is_default:true)
        end

        desc '获取热卖产品'
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
                data.push(t)
            end
            return data
        end

        desc '获取活动及对应产品'
        params do
            requires :activity_id, type:Integer
        end
        get 'activity_product' do
            object = {}
            t = Activity.find_by(id:params[:activity_id], is_show:true).image
            f = Product.where(activity_id: params[:activity_id], display:true).pluck(:id, :name, :image, :now_product_price)
            object[:activety_image] = t
            object[:product] = f
            return object
        end
    end
end
