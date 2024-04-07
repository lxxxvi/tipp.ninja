require "application_system_test_case"

class UserProfilesTest < ApplicationSystemTestCase
  test "user changes profile" do
    sign_in_user :antoine

    visit "/dashboard"

    click_link "Profile"

    assert_selector "h2", text: "antoine"
    assert_description "Rooting for", "🇫🇷 France"

    click_link "Edit profile"

    assert_selector "h2", text: "Edit profile"

    fill_in "Nickname", with: "Griezmann"

    select "Switzerland", from: "Rooting for"

    click_button "Save"

    assert_selector "h2", text: "Griezmann"
    assert_description "Rooting for", "🇨🇭 Switzerland"
  end

  private

  def assert_description(term, definition)
    assert_equal definition, find("dt", text: term).sibling("dd").text
  end
end
