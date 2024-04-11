require "test_helper"

class CommunityCreationServiceTest < ActiveSupport::TestCase
  test "creates community, community membership" do
    community = Community.new(name: "Atlético", access: "private")
    user = users(:antoine)

    service = CommunityCreationService.new(community, user)

    assert_difference -> { CommunityMembership.count }, +1 do
      assert_changes -> { Community.where(name: "Atlético").count }, from: 0, to: 1 do
        service.save
      end
    end

    assert_equal 1, community.members_count
    assert_equal 0, community.average_points
    assert_equal user, community.community_memberships.sole.user

    # TODO: calculates community.average_points, community_membership.ranking_position
  end
end
