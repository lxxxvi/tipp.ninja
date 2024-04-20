# frozen_string_literal: true

require "test_helper"

class FieldWithErrorComponentTest < ViewComponent::TestCase
  test "render" do
    community = Community.new
    community.validate

    render_inline FieldWithErrorComponent.new(community, :name)

    assert_selector "span", class: "field_with_errors", text: "can't be blank"
  end
end
