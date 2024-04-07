class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_readonly :url_identifier

  encrypts :email, deterministic: true

  validates :url_identifier, :nickname, presence: true
  validates :url_identifier, uniqueness: true
  validates :nickname, uniqueness: true

  belongs_to :rooting_for_team, optional: true, class_name: "Team"

  before_validation :initialize_fields, if: :new_record?

  def to_param
    url_identifier
  end

  private

  def initialize_fields
    self.url_identifier ||= SecureRandom.alphanumeric(8)
    self.nickname ||= url_identifier
  end
end
