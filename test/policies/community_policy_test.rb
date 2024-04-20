require "test_helper"

class CommunityPolicyTest < ActiveSupport::TestCase
  test "#show?" do
    # access through membership
    assert_permit users(:antoine), communities(:les_bleus), :show?
    assert_permit users(:kylian), communities(:les_bleus), :show?

    # access public
    assert_permit users(:bruno), communities(:france), :show?

    # no access
    assert_not_permit users(:bruno), communities(:les_bleus), :show?
  end

  test "#edit?" do
    assert_permit users(:antoine), communities(:les_bleus), :edit?
    assert_not_permit users(:kylian), communities(:les_bleus), :edit?
    assert_not_permit users(:bruno), communities(:les_bleus), :edit?
  end

  test "#update?" do
    assert_permit users(:antoine), communities(:les_bleus), :update?
    assert_not_permit users(:kylian), communities(:les_bleus), :update?
    assert_not_permit users(:bruno), communities(:les_bleus), :update?
  end

  test "#destroy?" do
    assert_permit users(:antoine), communities(:les_bleus), :destroy?
    assert_not_permit users(:kylian), communities(:les_bleus), :destroy?
    assert_not_permit users(:bruno), communities(:les_bleus), :destroy?
  end
end
