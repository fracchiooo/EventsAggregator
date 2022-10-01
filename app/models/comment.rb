class Comment < ApplicationRecord
    belongs_to :user
    has_many :like_comments
end
