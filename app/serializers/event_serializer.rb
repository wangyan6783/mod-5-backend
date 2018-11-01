class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category, :start_time, :end_time

  belongs_to :resort
end
