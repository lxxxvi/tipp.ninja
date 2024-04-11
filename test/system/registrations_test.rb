require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  test "user registers successfully" do
    visit "/"

    click_link "Let's go"

    click_link "Register"

    assert_selector "h2", text: "Register"
    assert_link "Sign in"

    fill_in "Email", with: "birgit@example.com"
    fill_in "Password", with: "abcdefgh"

    click_button "Register"

    assert_selector "h2", text: "Dashboard"
  end

  test "user fails to register" do
    visit "/"

    click_link "Let's go"

    click_link "Register"

    click_button "Register"

    assert_text "Email can't be blank"
    assert_text "Password can't be blank"

    fill_in "Email", with: "birgit@example.com"
    fill_in "Password", with: "short"

    click_button "Register"

    assert_text "too short"
  end
end
