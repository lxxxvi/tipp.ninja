require "test_helper"

class CommunityTest < ActiveSupport::TestCase
  test "validates" do
    community = Community.new

    assert_not community.valid?

    community.errors.to_a.tap do |errors|
      assert_equal 1, errors.size
      assert_includes errors, "Name can't be blank"
    end
  end

  test "#to_param" do
    assert_equal "xLESBLEUS", communities(:les_bleus).to_param
  end

  test "#global?" do
    assert_predicate communities(:global), :global?
    assert_not_predicate communities(:france), :global?
  end

  test ".global" do
    assert_equal communities(:global), Community.global
  end

  test ".user_is_member_of" do
    user = users(:bruno)

    assert_difference -> { Community.user_is_member_of(user).count }, +1 do
      CommunityMembership.create!(community: communities(:france), user:)
    end
  end

  test ".user_is_member_of_or_public_community" do
    user = users(:bruno)

    community_membership = CommunityMembership.new(community: communities(:france), user:)

    # No difference because membership is in public
    assert_no_difference -> { Community.user_is_member_of_or_public_community(user).count } do
      community_membership.save!
    end

    # Change membership from "France" (public) to "Les Bleus" (private) increases the count
    assert_difference -> { Community.user_is_member_of_or_public_community(user).count } do
      community_membership.update!(community: communities(:les_bleus))
    end
  end
end
