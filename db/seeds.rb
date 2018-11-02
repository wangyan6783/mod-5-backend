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

Resort.destroy_all
User.destroy_all
Event.destroy_all

resorts = HTTParty.get('https://skimap.org/SkiAreas/index.json')
events = HTTParty.get('https://www.skireg.com/api/search')

resorts.sample(100).each do |resort|
  Resort.create(name: resort["SkiArea"]["name"], region: resort["Region"][0]["name"], latitude: resort["SkiArea"]["geo_lat"], longitude: resort["SkiArea"]["geo_lng"], website_url: resort["SkiArea"]["official_website"], image_url: "https://image.jimcdn.com/app/cms/image/transf/none/path/sa6549607c78f5c11/image/i4328ae53a316c822/version/1510667937/luxurious-ski-resorts-courchevel-copyright-nikolpetr-european-best-destinations.jpg")
end

50.times do
  User.create(username: Faker::Internet.username, email: Faker::Internet.free_email, password: Faker::Internet.password)
end

150.times do
  Event.create(title: Faker::BackToTheFuture.character, description: Faker::BackToTheFuture.quote, date: Faker::BackToTheFuture.date, image_url: "https://www.zermatt.ch/extension/portal-zermatt/var/storage/images/media/bibliothek/aktivitaeten/winter/ski-snowboardfahren/skifahren-kick-off/2353119-3-ger-DE/Skifahren-Kick-Off_grid_700x365.jpg", resort_id: rand(1..500), host_id: rand(1..50))
end
