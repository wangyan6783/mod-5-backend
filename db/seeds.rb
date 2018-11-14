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

puts "delete live chat info begin"

# delete chat room when event is deleted
Event.all.each do |event|
  # if Rails.configuration.chatkit.get_room({ id: event[:chat_room_id] })
    Rails.configuration.chatkit.delete_room({ id: event[:chat_room_id] })
  # end
end

# delete user account from live chat kit
User.all.each do |user|
  # if Rails.configuration.chatkit.get_user({ id: user[:username] })
    Rails.configuration.chatkit.delete_user({ id: user[:username]})
  # end
end

puts "delete live chat info end"

puts "delete seed data begin"

Resort.destroy_all
User.destroy_all
Event.destroy_all
Comment.destroy_all
UserEvent.destroy_all

puts "delete seed data end"


resorts = HTTParty.get('https://skimap.org/SkiAreas/index.json')
events = HTTParty.get('https://www.skireg.com/api/search')

puts "create resorts begin"

resorts.sample(200).each do |resort|

  if resort["SkiArea"]["official_website"] == ""
    resort["SkiArea"]["official_website"] = "https://solitudemountain.com/"
  end

  image_urls = ["https://image.jimcdn.com/app/cms/image/transf/none/path/sa6549607c78f5c11/image/i4328ae53a316c822/version/1510667937/luxurious-ski-resorts-courchevel-copyright-nikolpetr-european-best-destinations.jpg", "https://s3.insidehook.com/Wilmot_Header_1483736110.jpg", "https://media.cntraveler.com/photos/549966eddf8f55bf04225ec0/master/pass/val-disere-france-cr-hemis-alamy.jpg", "http://www.powderhounds.com/site/DefaultSite/filesystem/images/Canada/Banff/Overview/Banff-05.jpg", "https://www.telegraph.co.uk/content/dam/Travel/leadAssets/27/54/vail2_2754509a.jpg?imwidth=450", "http://www.powderhounds.com/site/DefaultSite/filesystem/images/Canada/Fernie/Overview/Fernie-16.jpg", "https://static.independent.co.uk/s3fs-public/thumbnails/image/2014/03/31/16/skialamy.jpg?w968h681", "https://opengeorgia.ge/res/images/cache/1140x450/gudauri-image-01.jpg", "https://s3.insidehook.com/Wilmot_Header_1483736110.jpg", "http://sierrayuzawa.com/parts_top/DSC_1252w.jpg", "https://static.standard.co.uk/s3fs-public/thumbnails/image/2016/10/18/18/meribel.jpg", "https://dynaimage.cdn.cnn.com/cnn/q_auto,w_900,c_fill,g_auto,h_506,ar_16:9/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F180105163208-kitzbuhel-resort-guide-6.jpg", "https://www.nozawaholidays.com/wp-content/uploads/2016/10/lifts-DSC06195.jpg"]

  Resort.create(name: resort["SkiArea"]["name"], region: resort["Region"][0]["name"], latitude: resort["SkiArea"]["geo_lat"], longitude: resort["SkiArea"]["geo_lng"], website_url: resort["SkiArea"]["official_website"], image_url: image_urls.sample)
end

puts "create resorts end"

puts "create users begin"

avatars = ["https://cdn3.vectorstock.com/i/1000x1000/72/52/male-avatar-profile-icon-round-african-american-vector-18307252.jpg", "https://cdn1.vectorstock.com/i/1000x1000/73/15/female-avatar-profile-icon-round-woman-face-vector-18307315.jpg", "https://res.cloudinary.com/dfosmeuuq/image/upload/v1542218047/female-avatar-2.jpg", "https://res.cloudinary.com/dfosmeuuq/image/upload/v1542218097/man-avatar-3.jpg", "https://res.cloudinary.com/dfosmeuuq/image/upload/v1542218097/male-avatar-2.jpg", "https://res.cloudinary.com/dfosmeuuq/image/upload/v1542218078/female-avatar-3.jpg"]

10.times do
  User.create(username: Faker::Internet.username, email: Faker::Internet.free_email, password: Faker::Internet.password, avatar: avatars.sample)
end

puts "create users end"

puts "create live chat users begin"

# create live chat profile for each user
users_info = User.all.map do |user|
  {
    id: user[:username],
    name: user[:username]
  }
end
# create live chat user profile
Rails.configuration.chatkit.create_users({ users: users_info })

puts "create live chat users end"

puts "create events begin"
200.times do

  titles = ["Vertical Challenge", "The Great North Ski Adventure Weekend", "Ski Camps & Clinics", "Ski and Party", "Valentines Ski/ snowtube trip", "HSC weeklong trip to Sun Valley", "Ski trip to Steamboat Colorado", "Queenstown Winter Festival", "Snowbombing", "Sknowboxx Festival", "Fresh Mountain", "Tomorrowland Winter Festival", "Sapporo Snow Festival", "Snowattack Festival", "World Rookie Fest", "Rave on Snow", "Snowtunes", "Annual Thanksgiving Trip at Killington", "Mount Snow (2 Nights 2 Lifts + Bus)", "Music & Winter Sports Festival"]

  descriptions = ["We are going to Killington - the biggest & best ski resort in NorthEast. For this trip, we will stay at Quality Inn in Rutland. If you are coming with your friend, please indicate your friend/roommate's name when booking. If you come alone, we will match you with same gender trip goer. We will also have a coach bus or Benz Sprinter van so everyone can relate and avoid 5 hours-long drive.", "For this trip, we will stay at Snow Lake Lodge, Mount Snow's lakeside hotel with spectacular views of the mountain, Snow Lake Lodge is a real value. A free shuttle will take you to and from the slopes and you are walking distance from a great evening of entertainment at the Snowbarn (winter only). After a full day of play, take a soothing sauna, hop into the indoor or outdoor hot tub or visit the arcade. You’ll sleep well knowing your next day of fun on the slopes is just steps away", "Snowboxx never fails to deliver unbelievable snow festivals. The event is a mix of electronic music and snow sports with some of the biggest artists in Europe performing at the festival. Snow lovers can ski or snowboard the amazing Port du Soleil, explore the Burton Stash Park, or even ski across the border to Switzerland. Not a snow bunny just yet? No worries, take some beginner ski or snowboard lessons on one of the many slopes and soak up the festival atmosphere, bier (beer) in hand when you need a break!", "Join thousands of other festival ski bunnies as they party in the snow to some of the world’s hottest hip hop artists. Fresh Mountain runs from the 9th to the 16th March 2019 with a whole week of pre-parties, main events and, of course, an obligatory after party! Combine your love of snow and music in a festival never to forget.", "For this trip, we will stay at Quality Inn in Rutland. If you are coming with your friend, please indicate your friend/roommate's name when booking. If you come alone, we will match you with same gender trip goer. We will also have a coach bus or Benz Sprinter van so everyone can relate and avoid 5 hours-long drive.", "Ring in the New Year at Castle Mountain rated Top 10 in the World and enjoy 4 fun filled days of skiing/boarding and festivities. We stay at a gorgeous on-hill chalet by Green Chair w 8 rooms w a queen bed and 2 rooms w 2 twin beds/room. $325/person which includes breakfasts and lunches! Tickets and transportation not included. Discounted+ Castle Cards available at our socials for $68 which offer 50% off lift tickets ALL season. Sunshine cards include Castle too!", "Fun at Fernie is back! Two nights on-hill accom and charter bus to one of our favourite mountains. $265 includes 2 nites on-hill accom, bus, pizza w salad supper at the Rusty Edge Sat AND a sandwich for trip out. Enjoy a Beverage on the bus - Details to follow. Sunday night we will stop in the town of Fernie for supper ( your cost) before our trip back to Calgary. Lift tickets available at discounted rate ( RCR special rate on lift pass, we must reach a 25 ticket purchase for the special group rate) RCR discount card is also an option.", "Whitefish by Bus is a MUST this YEAR! Trip includes Bus ride, 3 nights on-hill accommodation with hot tub (bring your hot tub suit), 3 hot breakfasts, Saturday night Welcome Reception and free shuttles to/from Whitefish town! Starting at $350 CAD!!!", "Kevin Lee is hosting our trip to Red Mountain! SCSC is partnering with Backside Tours! Trip includes transportation on luxury coach bus, accommodations at the brand new European inspired Nowhere Special on-hill Hostel, 3 days skiing/boarding - 2 days at Red Mountain, 1 day at Whitewater!", "Trip includes 2 nights at Tayton Lodge - ski in/out. Enjoy relaxing in the outdoor hot tub, group gatherings and a quick walk to restaurants & bars at the Resort. Accommodation and breakfast/lunch, starting at $250 per person. Transportation is not included."]

  image_urls = [ "https://usskiandsnowboard.org/sites/default/files/images/static-pages/StaticPageHeader_1600x1200_Snowboard_Jamie_Action.jpg", "http://www.cloud-booking.net/pf/img/product/geilo365/2427/2427-2000x2000.jpg", "https://coresites-cdn.factorymedia.com/cooler_new/wp-content/uploads/2015/07/Snowboard-Shops-For-Women-In-The-UK-Roxy.jpg", "https://skioutabounds.com/wp-content/uploads/2013/11/boy-snowboarding1.jpg", "https://d2s0f1q6r2lxto.cloudfront.net/pub/ProTips/wp-content/uploads/2017/01/SnowboardingKids1.jpg", "http://www.bestwesternkelownahotel.com/assets/uploads/Headers/Packages/BW-Kelowna-Hotel-Ski-Snowboard-Packages.jpg", "http://coresites-cdn.factorymedia.com/mpora_new/wp-content/uploads/2016/08/Snowboarding-Beginners-Tips-Advice-UK.jpg", "https://www.action-outdoors.co.uk/images/default-source/images---alpine-snowboard/snowboard-beginner-landing2.jpg?sfvrsn=0", "https://res.cloudinary.com/dfosmeuuq/image/upload/v1542212916/jlewpyagqawrwkzxbxhk.png"]
  Event.create(title: titles.sample, description: descriptions.sample, date: Faker::Date.forward(365), image_url: image_urls.sample, resort_id: Resort.pluck(:id).sample, host_id: User.pluck(:id).sample)
end
puts "create events end"

puts "create live chat rooms begin"

# create live chat room for each event
Event.all.each do |event|
  host = User.find_by(id: event[:host_id])
  Rails.configuration.chatkit.create_room({ creator_id: host[:username], name: event[:title] })

  # assign chat room id to this event
  rooms = Rails.configuration.chatkit.get_user_rooms({ id: host[:username] })
  room = rooms[:body].find {|room| room[:name] == event[:title]}
  event.update(chat_room_id: room[:id])
end

puts "create live chat rooms end"

puts "create user events begin"

300.times do
  UserEvent.create(user_id: User.pluck(:id).sample, event_id: Event.pluck(:id).sample)
end
puts "create user events end"

puts "create comments begin"

content = ["I signed up but will have to clear with employer next week or two! Thanks.", " I am going to signup two tickets for this trip, one hotel room with ski rentals and lift. thanks.", "Left 2 spots. Book yours soon.", "Meet & greet is on tomorrow. Looking forward to meet everyone.", "Hello! Just wondering is there a lower price for anyone not taking the bus? Also, are the accommodations a hotel room with two beds? Thank you!", "Rooms have 2 beds in them. 2 people in a room.", "Great deal for 2 nights accommodation on the hill."]

300.times do
  Comment.create(content: content.sample, user_id: User.pluck(:id).sample, event_id: Event.pluck(:id).sample, like_count: rand(0..10))
end

puts "create comments end"
