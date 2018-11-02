class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  validates :email, uniqueness: true
  validates :password, :email, presence: true
end
