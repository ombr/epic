# Client
class Client < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_many :orders
  validates :email, email: true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def slug_candidates
    SecureRandom.uuid
  end
end
