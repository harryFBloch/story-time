class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :genres, through: :posts
  has_many :sentances, through: :posts
  has_secure_password
  validates :email, :password, :username, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true

end
