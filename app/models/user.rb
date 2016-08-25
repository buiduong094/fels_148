class User < ActiveRecord::Base
  include SessionsHelper
  before_save {self.email = email.downcase}
  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  has_secure_password

  has_many :activities
  has_many :lessons
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def current_user? user
    self == user
  end
end
