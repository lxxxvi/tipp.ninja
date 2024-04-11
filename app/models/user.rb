class User < ApplicationRecord
  include UrlIdentifiable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  encrypts :email, deterministic: true

  validates :nickname, presence: true
  validates :nickname, uniqueness: true

  belongs_to :rooting_for_team, optional: true, class_name: "Team"

  has_many :community_memberships, dependent: :destroy
  has_many :communities, through: :community_memberships

  before_validation :initialize_fields, if: :new_record?

  after_create :add_to_global_team!

  def to_param
    url_identifier
  end

  private

  def initialize_fields
    self.nickname ||= url_identifier
  end

  def add_to_global_team!
    community_memberships.find_or_initialize_by(community: Community.global).save!
  end
end
