class ResortSerializer < ActiveModel::Serializer
  attributes :id, :name, :region, :latitude, :longitude, :website_url, :image_url

  has_many :events
end
