class Community < ApplicationRecord
  include UrlIdentifiable

  GLOBAL = "global".freeze

  has_many :community_memberships, dependent: :destroy
  has_many :users, through: :community_memberships

  enum :access, {
    private: "private",
    public: "public"
  }, suffix: true, default: "private"

  scope :user_is_member_of, ->(user) { where(community_memberships: user.community_memberships) }
  scope :user_is_member_of_or_public_community, ->(user) {
    where(
      <<~SQL.squish, user_id: user.id
        communities.access = 'public'
        OR
        id IN (SELECT community_memberships.community_id
                 FROM community_memberships
                WHERE user_id = :user_id)
      SQL
    )
  }
  scope :ordered_by_global_first_then_alphabetically, -> {
    order(
      Arel.sql("CASE WHEN communities.url_identifier = 'global' THEN 1 ELSE 2 END ASC"),
      name: :asc
    )
  }

  before_validation :initialize_fields, if: :new_record?
  validates :name, :invitation_token, :members_count, :average_points, presence: true
  validates :members_count, numericality: { greater_than: 0, only_integer: true }
  validates :average_points, numericality: { greater_than_or_equal_to: 0 }

  def to_param
    url_identifier
  end

  def global?
    url_identifier == GLOBAL
  end

  def self.global
    find_by!(url_identifier: GLOBAL)
  end

  private

  def initialize_fields
    self.invitation_token ||= SecureRandom.alphanumeric(12)
  end
end
