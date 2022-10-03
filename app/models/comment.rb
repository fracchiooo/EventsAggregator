class Comment < ApplicationRecord
    belongs_to :user
    has_many :like_comments
    has_many :segnala_cs
end
