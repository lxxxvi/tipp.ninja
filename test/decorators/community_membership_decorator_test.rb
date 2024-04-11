require "test_helper"

class CommunityMembershipDecoratorTest < ActiveSupport::TestCase
  test "#display_ranking_position" do
    assert_equal 0, community_memberships(:global_antoine).decorate.display_ranking_position
  end
end
