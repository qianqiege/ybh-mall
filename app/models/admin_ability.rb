class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user.role_name == 'admin'
      can :manage, :all
    elsif user.role_name == 'db'
      can :manage, Order
      can :manage, ReturnRequest
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
    end
    can :read, ActiveAdmin::Page, name: "Dashboard"
  end
end
