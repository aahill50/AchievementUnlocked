class User < ActiveRecord::Base
  include Commentable

  validates :username, :password_digest, :session_token, presence: true

  has_many :goals, inverse_of: :user, dependent: :destroy

  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :author_id,
    inverse_of: :author
  )

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)
    @user && @user.is_password?(password) ? @user : nil
  end

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end


end
