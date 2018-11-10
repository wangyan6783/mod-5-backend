class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :date, :image_url, :users, :chat_room_id

  belongs_to :resort
  has_many :user_events
  has_many :comments

  def users
    object.users
  end
end
