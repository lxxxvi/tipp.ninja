class DeviseLayoutComponent < ViewComponent::Base
  attr_reader :title, :flash, :links, :resource, :resource_name

  delegate :main_app, to: :helpers

  def initialize(title:, flash:, links: [], resource: nil, resource_name: nil)
    @title = title
    @flash = flash
    @links = links
    @resource = resource
    @resource_name = resource_name
    super()
  end

  def messages
    flash_messages.concat(resource_error_messages)
  end

  private

  def resource_error_messages
    Array(resource&.errors&.full_messages)
  end

  def flash_messages
    flash.map(&:last)
  end
end
