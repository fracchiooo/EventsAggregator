class Event < ApplicationRecord
    has_many :comments
    has_many :like_events

    validates :event_id, :coordinates, :origin, presence: true
end
