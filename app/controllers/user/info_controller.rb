class User::InfoController < Wechat::BaseController
  before_action :programs

  def home
    @wechat_user = WechatUser.find(current_user)
  end

  def wallet
    if !current_user.user_id.nil?
      @wallet = ScoinAccount.find_by(user_id: current_user.user_id)
      @yi_coin = User.find_by(id: current_user.user_id)
      @scoin_account = ScoinAccount.where(user_id:current_user.user_id)
      @money = ScoinAccount.where(user_id: current_user.user_id)
      @sum = 0
      @money.each do |m|
        @sum = @sum + m.number
      end
    end
  end

  def health_record
    if !current_user.user_id.nil?
      @idcard = User.find(current_user.user_id)
      mall = Sdk::Mall.new
      @record = mall.record(@idcard.identity_card)
    end
  end

  def wechat_info
    @wechat_info = WechatUser.find(current_user)
  end

  def member_info
    @member = MemberRecord.where(user_id: current_user.user_id).take
  end

  def tds_record
    if !current_user.user_id.nil?
      @idcard = User.find(current_user.user_id)
      mall = Sdk::Mall.new
      @tds_record = mall.tds_report(@idcard.identity_card)
    end
  end

  def programs
    if !current_user.user_id.nil?
      @programs = HealthProgram.where(identity_card: User.find(current_user.user_id).identity_card)
      @time_programs = @programs.order(time: :desc).limit(10)
      @time = params[:format]
    end
  end

  def health_programs
    if !@time.nil?
      @search_programs = @programs.where(time: @time).take.product
      @only_number = JSON.parse(@search_programs)
      cart = current_user.cart || current_user.create_cart
      @only_number.each do |only_number|
       if product = Product.find_by(only_number: "1010")
         if !cart.nil?
           @line_item = cart.add_product(product,1)
         end
       end
     end
   end
  end

  def create_programs
    if params["commit"] == "加入到购物车"
      @time = params[:format]
      if !@time.nil?
        @search_programs = @programs.where(time: @time).take.product
        @only_number = JSON.parse(@search_programs)
        if !@only_number.nil?
          @only_number.each do |only_number|
            product = Product.find_by(only_number: only_number["产品编号"])
            if !product.nil?
              quantity = only_number["数量"].to_i
              @line_item = current_user.cart.add_product(product, quantity)
              ap @line_item
              if @line_item.save
                redirect_to mall_cart_path
                return
              end
            end
          end
        end
      end
    end
  end

end
