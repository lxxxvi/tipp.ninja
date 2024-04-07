class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def decorate
    @decorate ||= "#{self.class.name}Decorator".constantize.new(self)
  end
end
