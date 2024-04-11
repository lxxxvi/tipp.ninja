module UrlIdentifiable
  extend ActiveSupport::Concern

  included do
    attr_readonly :url_identifier

    before_validation :initialize_url_identifier, if: :new_record?

    validates :url_identifier, presence: true
    validates :url_identifier, uniqueness: true
  end

  private

  def initialize_url_identifier
    self.url_identifier ||= SecureRandom.alphanumeric(8)
  end
end
