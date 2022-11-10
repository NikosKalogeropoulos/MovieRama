class Movie < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :user, presence: true
    validates :title, uniqueness: { scope: :user}

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
end