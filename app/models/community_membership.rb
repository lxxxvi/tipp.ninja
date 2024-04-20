class CommunityMembership < ApplicationRecord
  belongs_to :community
  belongs_to :user

  validates :user_id, uniqueness: { scope: :community_id }

  enum :role, {
    member: "member",
    owner: "owner"
  }, default: "member"

  scope :ordered_by_ranking_position_then_user_nickname, -> {
    joins(:user).order("community_memberships.ranking_position ASC, users.nickname ASC")
  }
end
