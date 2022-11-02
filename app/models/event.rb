class Event < ApplicationRecord
    has_many :comments
    has_many :like_events

    validates :origin, presence: true
end
