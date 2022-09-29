class Comment < ApplicationRecord
    belongs_to :user

    has_many :users #utenti a cui piace il commento
end
