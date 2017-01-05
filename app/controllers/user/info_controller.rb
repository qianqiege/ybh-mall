class User::InfoController < Wechat::BaseController
  before_action :helath_programs

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

  def tds_record
    @idcard = User.find(current_user.user_id)
    mall = Sdk::Mall.new
    @tds_record = mall.tds_report(@idcard.identity_card)
  end

  def helath_programs
    @programs = HealthProgram.where(identity_card: User.find(current_user.user_id).identity_card)
    @products = Product.where(only_number: @programs.pluck(:only_number))
    ap @programs
  end

  def create_programs
    if params["commit"] == "加入到购物车"
      @programs.each do |program|
        if product = Product.find_by(only_number: program.only_number)
          @line_item = current_user.cart.add_product(product, program.number)
          ap @line_item
          @line_item.save
        end
      end
    else
      @programs.each do |program|
        if product = Product.find_by(only_number: program.only_number)
          @line_item = current_user.cart.add_product(product, program.number)
        end
      end
    end
  end

end
