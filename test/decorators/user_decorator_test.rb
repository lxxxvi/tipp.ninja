require "test_helper"

class UserDecoratorTest < ActiveSupport::TestCase
  test "#display_rooting_for_team_flag" do
    assert_equal "🇫🇷", users(:antoine).decorate.display_rooting_for_team_flag
  end

  test "#display_rooting_for_team_flag, rooting for team NOT set" do
    assert_equal "🏁", User.new.decorate.display_rooting_for_team_flag
  end

  test "#display_rooting_for_team_name" do
    assert_equal "France", users(:antoine).decorate.display_rooting_for_team_name
  end

  test "#display_rooting_for_team_name, rooting for team NOT set" do
    assert_equal "Not picked yet", User.new.decorate.display_rooting_for_team_name
  end
end
