# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    can :read, Want
    can :manage, Want, user_id: user_id
    can :read, Have
    can :manage, Have, user_id: user_id
    can :read, User
    can :update, User, id: user_id
    can :create, Trade
    can(:manage, Trade) { |trade| [trade.user, trade.with_user].include?(user) }
  end

  private

  def user_id
    @user.id
  end
end
