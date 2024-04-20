class FieldWithErrorComponent < ViewComponent::Base
  attr_reader :object, :attribute

  def initialize(object, attribute)
    @object = object
    @attribute = attribute
    super()
  end

  def render?
    errors.any?
  end

  def call
    tag.span(error_messages, class: "field_with_errors px-6 text-red-400")
  end

  private

  def errors
    @errors ||= object.errors[attribute.to_sym]
  end

  def error_messages
    errors.join(", ")
  end
end
