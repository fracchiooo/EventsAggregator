class LikeComment < ApplicationRecord
  validates :user, uniqueness: {scope: :comment_id}
  belongs_to :user
  belongs_to :comment
end
