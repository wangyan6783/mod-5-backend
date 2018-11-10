# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rubygems'
require 'httparty'
require 'faker'

# https://github.com/stympy/faker

# delete user account from live chat kit
User.all.each do |user|
  Rails.configuration.chatkit.delete_user({ id: user[:username]})
end

# delete chat room when event is deleted
Event.all.each do |event|
  Rails.configuration.chatkit.delete_room({ id: event[:chat_room_id] })
end

Resort.destroy_all
User.destroy_all
Event.destroy_all
Comment.destroy_all
UserEvent.destroy_all


resorts = HTTParty.get('https://skimap.org/SkiAreas/index.json')
events = HTTParty.get('https://www.skireg.com/api/search')

resorts.sample(100).each do |resort|
  Resort.create(name: resort["SkiArea"]["name"], region: resort["Region"][0]["name"], latitude: resort["SkiArea"]["geo_lat"], longitude: resort["SkiArea"]["geo_lng"], website_url: resort["SkiArea"]["official_website"], image_url: "https://image.jimcdn.com/app/cms/image/transf/none/path/sa6549607c78f5c11/image/i4328ae53a316c822/version/1510667937/luxurious-ski-resorts-courchevel-copyright-nikolpetr-european-best-destinations.jpg")
end

30.times do
  User.create(username: Faker::Internet.username, email: Faker::Internet.free_email, password: Faker::Internet.password)
end

# create live chat profile for each user
users_info = User.all.map do |user|
  {
    id: user[:username],
    name: user[:username]
  }
end
# create live chat user profile
Rails.configuration.chatkit.create_users({ users: users_info })

150.times do
  titles = ["Vertical Challenge", "The Great North Ski Adventure Weekend", "Ski Camps & Clinics", "Ski and Party", "Valentines Ski/ snowtube trip", "HSC weeklong trip to Sun Valley", "Ski trip to Steamboat Colorado"]
  descriptions = []
  date = []
  image_urls = []
  Event.create(title: titles.sample, description: Faker::BackToTheFuture.quote, date: Faker::BackToTheFuture.date, image_url: "https://www.zermatt.ch/extension/portal-zermatt/var/storage/images/media/bibliothek/aktivitaeten/winter/ski-snowboardfahren/skifahren-kick-off/2353119-3-ger-DE/Skifahren-Kick-Off_grid_700x365.jpg", resort_id: rand(1..500), host_id: rand(1..50))
end

# create live chat room for each event
Event.all.each do |event|
  host = User.find(event[:host_id])
  Rails.configuration.chatkit.create_room({ creator_id: host[:username], name: event[:title] })
end

300.times do
  UserEvent.create(user_id: User.pluck(:id).sample, event_id: Event.pluck(:id).sample)
end

300.times do
  Comment.create(content: "looking forward!", user_id: User.pluck(:id).sample, event_id: Event.pluck(:id).sample, like_count: 10)
end
