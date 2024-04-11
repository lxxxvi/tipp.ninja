class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    record == user
  end

  def update?
    record == user
  end
end
