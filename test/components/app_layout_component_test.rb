require "test_helper"

class AppLayoutComponentTest < ViewComponent::TestCase
  test "render" do
    render_inline AppLayoutComponent.new(user: users(:antoine))

    assert_selector "nav"
    assert_selector "main"
  end
end
