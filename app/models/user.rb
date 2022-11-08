class User < ApplicationRecord
    validates :username, uniqueness: true, presence: true
    validates :password_digest, presence: {message: "Password can't be blank"}
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :session_token, presence: true

    after_initialize :ensure_session_token

    attr_reader :password

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def password=(password)
       @password = password 
       self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    private

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

end