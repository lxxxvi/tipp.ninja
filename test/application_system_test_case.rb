require "test_helper"
require "capybara/rails"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :rack_test

  # def sign_in_user(fixture_key, password = "abc")
  #   user = users(fixture_key)
  #   visit login_path
  #   fill_in "Email address", with: user.email
  #   fill_in "Password", with: password
  #   click_button "Sign in"
  # end

  def sign_out
    click_button "Sign out"
  end

  def sign_in_user(fixture_key)
    sign_in users(fixture_key)
  end

  # def navigate_to(menu_item)
  #   within("nav.main-nav") do
  #     click_link menu_item, match: :first
  #   end
  # end

  def using_browser(&)
    Capybara.using_driver(find_driver, &)
  end

  def click_with_delete(element)
    if Capybara.current_driver == :rack_test
      page.driver.submit :delete, element["href"], {}
    else
      element.click
      accept_alert
    end
  end

  def find_driver
    return :selenium if ENV["DEBUG"].present?

    :selenium_headless
  end

  def assert_data_test(selector, **args)
    assert_selector("[data-test='#{selector}']", **args)
  end

  def assert_no_data_test(selector, **args)
    assert_no_selector("[data-test='#{selector}']", **args)
  end
end
