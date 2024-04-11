class CommunityCreationService
  def initialize(community, user)
    @community = community
    @user = user
  end

  def save
    return false unless @community.valid?

    ApplicationRecord.transaction do
      community.save

      community.community_memberships.create(role: :owner, user:)
    end
  end

  private

  attr_reader :community, :user
end
