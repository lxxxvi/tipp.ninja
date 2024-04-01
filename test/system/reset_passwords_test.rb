require "application_system_test_case"

class ResetPasswordsTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper

  test "user forgets password" do
    visit "/"

    click_link "Let's go"

    click_link "Reset your password!"

    assert_selector "h2", text: "Forgot your password?"

    fill_in "Email", with: "antoine@example.com"

    assert_emails 1 do
      click_button "Reset my memory!"
    end

    assert_selector "h2", text: "Sign in"
    assert_selector(
      ".flash",
      text: "You will receive an email with instructions on how to reset your password in a few minutes."
    )
  end

  test "user fails to reset password, wrong email address" do
    visit new_user_password_path

    assert_selector "h2", text: "Forgot your password?"

    assert_no_emails do
      click_button "Reset my memory!"
    end

    assert_selector "h2", text: "Forgot your password?"
    assert_selector ".flash", text: "Email can't be blank"
  end

  test "user sets new password" do
    reset_password_token = users(:antoine).send_reset_password_instructions

    visit edit_user_password_path(reset_password_token:)

    assert_selector "h2", text: "Change your password"

    fill_in "New password", with: "so-secret!"

    click_button "Change it now"

    assert_selector "h2", text: "Dashboard"
  end

  test "user fails to reset password, wrong new password" do
    reset_password_token = users(:antoine).send_reset_password_instructions

    visit edit_user_password_path(reset_password_token:)

    assert_selector "h2", text: "Change your password"

    click_button "Change it now"

    assert_selector "h2", text: "Change your password"
    assert_selector ".flash", text: "Password can't be blank"
  end
end
