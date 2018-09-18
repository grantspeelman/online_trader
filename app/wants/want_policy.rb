# frozen_string_literal: true

class WantPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    update?
  end
end
