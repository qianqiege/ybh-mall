class User::InfoController < Wechat::BaseController
  before_action :programs

  def invitation
    if current_user.user
      url = user_binding_url({invitation_id: current_user.user.invitation_card})
      @qrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
      @invitation_card = User.find(current_user.user_id).invitation_card
    else
      redirect_to '/user/binding'
    end
  end

  def invitation_friend
    if !current_user.user_id.nil?
      @my_name = User.find(current_user.user_id)
      @invitation_friend = User.where(invitation_id: @my_name.id)
    end
  end

  def home
    @wechat_user = WechatUser.find(current_user)
  end

  def setting
    if !(current_user.mobile.present? && current_user.user.present?)
      redirect_to '/user/binding'
      return
    end
    @wechat_user = WechatUser.find(current_user)
    @identity_cards = current_user.user.identity_cards
    @show_upload_btn = @identity_cards.count < 4
  end

  def upload_image
    url = $wechat_client.download_media_url(params["serverId"])
    current_user.user.identity_cards.create(remote_image_url: url)

    render_success
  end

  def wallet_scoin
    if !current_user.user_id.nil?
      @scoin_account = ScoinAccount.where(user_id:current_user.user_id)
      @sum = 0
      @count = 0
      @scoin_account.each do |scoin|
        if !scoin.number.nil?
          @sum = @sum + scoin.number
        end
        if !scoin.id.nil?
          @scoin_type = ScoinType.where(id: ScoinRecord.where(scoin_account_id: scoin.id).pluck(:scoin_type_id))
          @scoin_type.each do |type|
            @count = @count + type.count
          end
        end
      end
    end
  end

  def wallet
    @ycoin = User.find(current_user.user_id)
  end

  def do_query_wallet
    if !params[:username].present? || !params[:password].present?
      render json: { status: 'error', message: '请填写用户名和密码' }
    else
      if QueryCoin.query(params[:username], params[:password])
        render json: { status: 'ok' }
      else
        render json: { status: 'error', message: '登录失败，账号或密码不正确'}
      end
    end
  end

  def query_wallet
    @ycoin = User.find(current_user.user_id)
    ap @ycoin
    @coin = QueryCoin.query(params[:username], params[:password])
    logger.info @coin
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

  def scoin_info
    @id = params[:format]
    @scoin_record = ScoinRecord.where(scoin_account_id: @id)
    @scoin_account = ScoinAccount.find_by(id: @id)
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
              @line_item.save
            end
          end
          redirect_to mall_cart_path
          return
        end
      end
    end
  end

end
