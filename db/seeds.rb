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

resorts.sample(500).each do |resort|
  Resort.create(name: resort["SkiArea"]["name"], region: resort["Region"][0]["name"], latitude: resort["SkiArea"]["geo_lat"], longitude: resort["SkiArea"]["geo_lng"], website_url: resort["SkiArea"]["official_website"])
end

50.times do
  User.create(username: Faker::Internet.username, email: Faker::Internet.free_email, password: Faker::Internet.password)
end

50.times do
  Event.create(title: Faker::BackToTheFuture.character, description: Faker::BackToTheFuture.quote, category: "Youth", start_time: Faker::BackToTheFuture.date, end_time: Faker::BackToTheFuture.date, resort_id: rand(1..500), host_id: rand(1..50))
end
