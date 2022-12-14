class User < ApplicationRecord
    validates :username, uniqueness: true, presence: true
    validates :password_digest, presence: {message: "Password can't be blank"}
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :session_token, presence: true

    after_initialize :ensure_session_token

    attr_reader :password

    has_many :movies,
        dependent: :destroy,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Movie

    has_many :reactions, dependent: :destroy

    has_many :movies_reacted,
        through: :reactions,
        source: :movie

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

    def password=(password)
       @password = password 
       self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def likes_movie(movie_id)
        self.reactions.where(ttype: Reaction::LIKE, movie_id: movie_id).count
    end

    def hates_movie(movie_id)
        self.reactions.where(ttype: Reaction::HATE, movie_id: movie_id).count
    end

    private

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

end