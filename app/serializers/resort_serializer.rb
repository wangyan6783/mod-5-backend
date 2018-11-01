class ResortSerializer < ActiveModel::Serializer
  attributes :id, :name, :region, :latitude, :longitude, :website_url, :image_url
end
