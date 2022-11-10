class Movie < ApplicationRecord
    validates :title, presence: true, uniqueness: {scope: :user}
    validates :description, presence: true
    validates :user, presence: true

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    has_many :reactions

    has_many :users_reacted,
        through: :reactions,
        source: :user
    
    def likes
        @likes = self.reactions.where(ttype: Reaction::LIKE).count
    end

    def hates
        @hates = self.reactions.where(ttype: Reaction::HATE).count
    end

end