require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  test "#show?" do
    assert_permit users(:antoine), users(:bruno), :show?
  end

  test "#edit?, own" do
    assert_permit users(:antoine), users(:antoine), :edit?
  end

  test "#edit?, other" do
    assert_not_permit users(:antoine), users(:bruno), :edit?
  end

  test "#update?, own" do
    assert_permit users(:antoine), users(:antoine), :update?
  end

  test "#update?, other" do
    assert_not_permit users(:antoine), users(:bruno), :update?
  end
end
