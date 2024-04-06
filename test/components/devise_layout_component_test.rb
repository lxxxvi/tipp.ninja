require "test_helper"

class DeviseLayoutComponentTest < ViewComponent::TestCase
  test "render, just title" do
    component = DeviseLayoutComponent.new(
      title: "This is a title",
      flash: [],
      links: [],
      resource: User.new,
      resource_name: :user
    )

    render_inline component

    assert_selector "h2", text: "This is a title"
    assert_no_selector "a"
  end

  test "render, some links" do
    component = DeviseLayoutComponent.new(
      title: "This is a title",
      flash: [],
      links: [:sign_in, :register, :does_not_exist],
      resource: User.new,
      resource_name: :user
    )

    render_inline component

    assert_selector "a", count: 2

    assert_link "Sign in"
  end

  test "render, some messages" do
    flash = [["key", "message from flash"]]
    resource = User.new
    resource.validate

    component = DeviseLayoutComponent.new(
      title: "This is a title",
      flash:,
      links: [],
      resource:,
      resource_name: :user
    )

    render_inline component

    assert_selector ".flash", text: "message from flash"
    assert_selector ".flash", text: "Email can't be blank"
    assert_selector ".flash", text: "Password can't be blank"
  end
end
