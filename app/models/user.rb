class User < ApplicationRecord
  has_secure_password
  has_many :user_events
  has_many :events, through: :user_events
  has_many :user_tutorials
  has_many :tutorials, through: :user_tutorials
  validates :username, uniqueness: true
  # validates :password, :username, presence: true
end
