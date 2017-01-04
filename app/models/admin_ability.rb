class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user.role_name == 'admin'
      can :manage, :all
    elsif user.role_name == 'db'
      can :manage, Order
      can :manage, ReturnRequest
    end
    can :read, ActiveAdmin::Page, name: "Dashboard"
  end
end
