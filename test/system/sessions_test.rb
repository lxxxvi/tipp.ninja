require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  test "user signs in successfully" do
    visit "/"

    click_link "Let's go"

    assert_selector "h2", text: "Sign in"

    fill_in "Email", with: "antoine@example.com"
    fill_in "Password", with: "abcdefgh"

    click_button "Sign in"

    assert_selector "h2", text: "Dashboard"
  end

  test "user fails to sign in" do
    visit new_user_session_path

    fill_in "Email", with: "antoine@example.com"
    fill_in "Password", with: "wrongpassword"

    click_button "Sign in"

    assert_selector "h2", text: "Sign in"
    assert_selector ".flash", text: "Invalid Email or password."
  end

  test "user signs out" do
    sign_in_user :antoine

    visit "/dashboard"

    click_link "Profile"

    click_button "Sign out"

    click_link "Let's go"

    assert_selector "h2", text: "Sign in"
  end
end
