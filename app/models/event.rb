# Event
class Event < ActiveRecord::Base
  has_and_belongs_to_many :images
  has_and_belongs_to_many :clients

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
