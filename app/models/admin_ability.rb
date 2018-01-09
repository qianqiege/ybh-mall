class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user.role_name == 'admin'
      can :manage, :all
    elsif user.role_name == 'db'
      can :manage, Order
      can :manage, Product
      can :manage, ReturnRequest
      can :manage, User
      can :manage, PurchaseOrder
      can :manage, StockOut
    elsif user.role_name == 'spinebuild'
      can :manage, Rank
      can :manage, SpineBuild
      can :manage, Workstation
    elsif user.role_name == 'mall'
      can :manage, Product
      can :manage, ReturnRequest
      can :manage, Order
    elsif user.role_name == 'scoin_admin'
      can :manage, ScoinAccount
      can :manage, ScoinRecord
      can :manage, ScoinType
      can :manage, Order
      can :manage, ScoinAccountOrderRelation
    elsif user.role_name == 'activity_admin'
      can :manage, Activity
      can :manage, ActivityRule
    elsif user.role_name == 'market'
      can :manage, Product
      can :manage, Slide
      can :manage, Program
    elsif user.role_name == 'finance'
      can :manage, Order
      can :manage, ReturnRequest
      can :manage, ExchangeRecord
      can :manage, User
      can :manage, PresentedRecord
      can :manage, Integral
      can :manage, CashRecord
      can :manage, DoctorRebate
    elsif user.role_name == 'customer_service'
      can :manage, Advice
      can :manage, AdviceType
      can :manage, User
      can :manage, WechatUser
      can :manage, Order
      can :manage, ReturnRequest
      can :manage, CashRecord
      can :manage, PresentedRecord
      can :manage, Integral
      can :manage, ExchangeRecord
    elsif user.role_name == 'tester'
      can :manage, Order
      can :manage, Product
      can :manage, Activity
      can :manage, ActivityRule
      can :manage, PresentedRecord
      can :manage, Integral
      can :manage, WechatUser
      can :manage, User
      can :manage, Program
      can :manage, HealthProgram
      can :manage, ExchangeRecord
    elsif user.role_name == 'parallel_shop'
      can [:update,:read]
      can :read,            ShopOrder,      parallel_shop_id:   user.parallel_shop.id
      can :manage,          StockOut,       parallel_shop_id:   user.parallel_shop.id
      can :manage,          PurchaseOrder,  parallel_shop_id:   user.parallel_shop.id
      can :manage,          SaleProduct,    parallel_shop_id:   user.parallel_shop.id
      can :read,            Stock,          parallel_shop_id:   user.parallel_shop.id
      can [:update,:read],  ParallelShop,   id:                 user.parallel_shop.id
    end
    can :read, ActiveAdmin::Page, name: "Dashboard"
  end
end
