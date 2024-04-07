ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Policy helpers
    def assert_permit(user, record, action)
      assert(
        permit(user, record, action),
        "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
      )
    end

    def assert_not_permit(user, record, action)
      assert_not(
        permit(user, record, action),
        "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
      )
    end

    def permit(user, record_or_class, action)
      cls = record_or_class.is_a?(Class) ? "#{record_or_class}Policy" : "#{record_or_class.class}Policy"
      cls.constantize.new(user, record_or_class).public_send(action)
    end
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def sign_in_user(fixture_key)
    sign_in users(fixture_key)
  end
end
