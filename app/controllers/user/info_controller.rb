class User::InfoController < Wechat::BaseController
  before_action :helath_programs
  before_action :program

  def home
    @wechat_user = WechatUser.find(current_user)
  end

  def helath_record
    @idcard = User.find(current_user.user_id)
    mall = Sdk::Mall.new
    @record = mall.record(@idcard.identity_card)
  end

  def wechat_info
    @wechat_info = WechatUser.find(current_user)
  end

  def member_info
    @member = MemberRecord.where(user_id: current_user.user_id).take
  end

  def programs
    @time_programs = @programs.order(time: :desc).limit(10)
  end

  def tds_record
    @idcard = User.find(current_user.user_id)
    mall = Sdk::Mall.new
    @tds_record = mall.tds_report(@idcard.identity_card)
  end

  def program
    @programs = HealthProgram.where(identity_card: User.find(current_user.user_id).identity_card)
  end

  def helath_programs
    @only_number = HealthProgram.where(identity_card: User.find(current_user.user_id).identity_card,time: params[:format])
    @programtime = params[:format]
    @products = Product.where(only_number: @only_number.pluck(:only_number))

    @only_number.each do |only_number|
      if product = Product.find_by(only_number: only_number.only_number)
        @line_item = product
      end
    end
  end

  def create_programs
    @number = HealthProgram.where(identity_card: User.find(current_user.user_id).identity_card,time: params[:format])
    if !@number.nil?
      @number.each do |number|
        if product = Product.find_by(only_number: number.only_number)
          @line_item = current_user.cart.add_product(product, number.number)
          if @line_item.save
            @a = true
          else
            @a = false
          end
        end
      end
    end
  end

end
