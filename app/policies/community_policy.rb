class CommunityPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    record.public_access? || member?
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    membership&.owner?
  end

  def member?
    membership&.present?
  end

  def membership
    @membership ||= record.community_memberships.find_by(user:)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.user_is_member_of_or_public_community(user)
    end

    private

    attr_reader :user, :scope
  end
end
