class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user.email == 'admin@example.com'
      can :manage, :all
    elsif user.role_name == 'db'
      can :manage, Order
      can :manage, ReturnRequest
      can :read, ActiveAdmin::Page, name: "Dashboard"
    end
  end
end
