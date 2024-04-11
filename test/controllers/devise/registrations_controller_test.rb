require "test_helper"

class Devise::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "#new, when signed in" do
    sign_in_user :antoine

    get new_user_registration_path

    follow_redirect!

    assert_response :success
  end

  test "#create, adds new user to global community" do
    assert_nil User.find_by(email: "buffon@example.com")

    post user_registration_path, params: {
      user: {
        email: "buffon@example.com",
        password: "forza-italia-2006"
      }
    }

    follow_redirect!

    assert_response :success

    User.find_by!(email: "buffon@example.com").communities.tap do |users_communities|
      assert_equal 1, users_communities.count
      assert_equal communities(:global), users_communities.first
    end
  end

  test "#create, when signed in" do
    sign_in_user :antoine

    post user_registration_path, params: {}

    follow_redirect!

    assert_response :success
  end
end
