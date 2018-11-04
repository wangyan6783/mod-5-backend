class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :date, :image_url

  belongs_to :resort
  has_many :user_events
  has_many :users
end
