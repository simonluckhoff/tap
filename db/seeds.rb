# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing data
require 'faker'

puts "Clearing old data..."
Follow.destroy_all
Like.destroy_all
Share.destroy_all
PostInterest.destroy_all
UserInterest.destroy_all
Comment.destroy_all
Post.destroy_all
Interest.destroy_all
Message.destroy_all
Chat.destroy_all
User.destroy_all

# Create interests
puts "Creating interests..."
interests = [
  'Travel',
  'Food',
  'Sports',
  'Animals',
  'Gaming',
  'Photography'
].map do |title|
  Interest.create!(
    title: title,
    # description: "All about #{title.downcase}"
  )
end

# Create users
matt = User.create(
  email: 'mattdenton94@gmail.com',
  password: 'Tasneem@10',
  username: 'Matt',
  bio: 'Dad, dog dad, husband, and world changer!'
)

  matt.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt_profile_image.jpeg")),
    filename: "matt_profile_image.jpeg",
    content_type: "image/jpeg"
)

simon = User.create(
  email: 'simonluckhoff@gmail.com',
  password: 'kaptein',
  username: 'sims7878',
  bio: 'Car photographer and wannabe coder!'
)

simon.photo.attach(
  io: File.open(Rails.root.join("app/assets/images/simon_profile_image.png")),
  filename: "simon_profile_image.png",
  content_type: "image/jpeg"
)

yasha = User.create(
  email: 'yasha@gmail.com',
  password: 'password',
  username: 'Yasha',
  bio: 'Mom and coder!'
)

yasha.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha_profile_image.jpg")),
    filename: "yasha_profile_image.jpg",
    content_type: "image/jpeg"
  )

  puts "Creating posts..."
  post = Post.create!(
    user: matt,
    content: 'I love being a soccer dad!'
  )

# Create posts
puts "Creating posts..."
users.each do |user|
  3.times do |i|
    puts "creating a user"
    post = Post.new(
      user: "MattDenton94",
      content: "I love being a soccer dad! ##{interests.sport}"
    )
      # Attach a random image to the post
      post.photo.attach(
        io: File.open(Rails.root.join("app/assets/images/user#{rand(1..15)}.jpg")),
        filename: "post.jpg",
        content_type: "image/jpeg"
      )
      post.save
  end
end

# Create follows
puts "Creating follows..."
matt = User.find_by(email: 'mattdenton94@gmail.com')
simon = User.find_by(email: 'simonluckhoff@gmail.com')
yasha = User.find_by(email: 'yasha@gmail.com')

Follow.create!(follower: matt, following: simon)
Follow.create!(follower: matt, following: yasha)
Follow.create!(follower: simon, following: matt)
Follow.create!(follower: simon, following: yasha)
Follow.create!(follower: yasha, following: matt)
Follow.create!(follower: yasha, following: simon)

# Create likes
puts "Creating likes..."
matt = User.find_by(email: 'mattdenton94@gmail.com')
simon = User.find_by(email: 'simonluckhoff@gmail.com')
yasha = User.find_by(email: 'yasha@gmail.com')

posts = Post.all

# Matt likes 5 random posts
posts.sample(5).each do |post|
  Like.create!(
    user: matt,
    post: post
  )
end

# Simon likes 5 random posts
posts.sample(5).each do |post|
  Like.create!(
    user: simon,
    post: post
  )
end

# Yasha likes 5 random posts
posts.sample(5).each do |post|
  Like.create!(
    user: yasha,
    post: post
  )
end

# Assign interests to users
puts "Creating user interests..."

# Assign specific interests to users
matt = User.find_by(email: 'mattdenton94@gmail.com')
simon = User.find_by(email: 'simonluckhoff@gmail.com')
yasha = User.find_by(email: 'yasha@gmail.com')

sport = Interest.find_by(title: 'Sports')
animals = Interest.find_by(title: 'Animals')
photography = Interest.find_by(title: 'Photography')
gaming = Interest.find_by(title: 'Gaming')
travel = Interest.find_by(title: 'Travel')
food = Interest.find_by(title: 'Food')

UserInterest.create!(user: matt, interest: sport)
UserInterest.create!(user: matt, interest: animals)
UserInterest.create!(user: simon, interest: photography)
UserInterest.create!(user: simon, interest: gaming)
UserInterest.create!(user: yasha, interest: travel)
UserInterest.create!(user: yasha, interest: food)

# Assign interests to posts
puts "Creating post interests..."
posts.each do |post|
  case post.user
  when matt
    [sport, animals].each do |interest|
      PostInterest.create!(
        post: post,
        interest: interest
      )
    end
  when simon
    [photography, gaming].each do |interest|
      PostInterest.create!(
        post: post,
        interest: interest
      )
    end
  when yasha
    [travel, food].each do |interest|
      PostInterest.create!(
        post: post,
        interest: interest
      )
    end
  end
end

puts "Seed completed!"
puts "Created:"
puts "- #{User.count} users"
puts "- #{Post.count} posts"
puts "- #{Interest.count} interests"
puts "- #{Follow.count} follows"
puts "- #{Like.count} likes"
puts "- #{Share.count} shares"
puts "- #{UserInterest.count} user interests"
puts "- #{PostInterest.count} post interests"
