class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :avatar, :bio

  has_many :events
  has_many :tutorials
end
