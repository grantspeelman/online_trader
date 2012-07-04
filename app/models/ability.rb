class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'admin'
      can :manage, :all
      cannot :create, User
    else
      can :read, Want
      can :manage, Want, :user_id => user.id
      can :read, Have
      can :manage, Have, :user_id => user.id
      can :read, User
      can :update, User, :id => user.id
      can :create, Trade
      can :manage, Trade do |trade|
        trade.user == user || trade.with_user == user
      end
    end
  end
end
