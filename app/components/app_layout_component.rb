class AppLayoutComponent < ViewComponent::Base
  attr_reader :user

  renders_one :title
  renders_one :primary_action

  def initialize(user:)
    @user = user
    super()
  end
end
