require "test_helper"

class Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "#new, when signed in" do
    sign_in_user :antoine

    get new_user_session_path

    follow_redirect!

    assert_response :success
  end

  test "#create, when signed in" do
    sign_in_user :antoine

    post user_session_path, params: {}

    follow_redirect!

    assert_response :success
  end

  test "#destroy, when NOT signed in" do
    get destroy_user_session_path

    assert_response :not_found
  end
end
