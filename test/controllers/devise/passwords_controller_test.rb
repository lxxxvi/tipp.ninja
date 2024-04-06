require "test_helper"

class Devise::PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "#new, when signed in" do
    sign_in_user :antoine

    get new_user_password_path

    follow_redirect!

    assert_response :success
  end

  test "#create, when signed in" do
    sign_in_user :antoine

    post user_password_path, params: {}

    follow_redirect!

    assert_response :success
  end
end
