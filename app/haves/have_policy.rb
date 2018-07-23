class HavePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def show?
    user.id == record.user_id
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
