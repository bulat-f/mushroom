class User < ActiveRecord::Base

  has_many :courses, foreign_key: "tutor_id", dependent: :destroy

  has_secure_password

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_NUM_REGEX = /\+\d{11}/
  
  validates :surname, presence: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, format: { with: VALID_PHONE_NUM_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
