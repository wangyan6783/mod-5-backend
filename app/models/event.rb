class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events
  has_many :comments
  belongs_to :resort
  validates :title, :date, presence: true
end
