class Reaction < ApplicationRecord
    REACTION_TYPES = %w(LIKE HATE).freeze
    HATE = "HATE".freeze
    LIKE = "LIKE".freeze

    validates :user_id, uniqueness: {scope: [:movie_id]} 
    validates :ttype, :user_id, :movie_id, presence: true
    validates :ttype, inclusion: {in: REACTION_TYPES, message: "%{value} is not a valid reaction"}
    
    belongs_to :user
    belongs_to :movie

end