class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :event_id, :like_count, :user

  belongs_to :user
end
