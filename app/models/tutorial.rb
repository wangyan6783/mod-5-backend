class Tutorial < ApplicationRecord
  has_many :user_tutorials
  has_many :users, through: :user_tutorials
end
