require "test_helper"

class TeamDecoratorTest < ActiveSupport::TestCase
  test "#display_full" do
    assert_equal "🇩🇪 Germany (GER)", teams(:ger_team).decorate.display_full
  end

  test "#to_option" do
    germany = teams(:ger_team)
    option = germany.decorate.to_option

    assert_equal 2, option.size
    assert_equal "🇩🇪 Germany (GER)", option.first
    assert_equal germany.id, option.second
  end
end
