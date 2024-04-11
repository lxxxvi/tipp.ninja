require "test_helper"

class CommunityMembershipTest < ActiveSupport::TestCase
  test "validates" do
    community_membership = CommunityMembership.new

    assert_not community_membership.valid?

    community_membership.errors.to_a.tap do |errors|
      assert_equal 2, errors.count

      assert_includes errors, "Community must exist"
      assert_includes errors, "User must exist"
    end

    assert_equal "member", community_membership.role
    assert_equal 0, community_membership.ranking_position
  end
end
