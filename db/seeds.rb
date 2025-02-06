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
  'Technology',
  'Travel',
  'Food',
  'Music',
  'Sports',
  'Art',
  'Books',
  'Animals',
  'Cars',
  'Fashion',
  'Fitness',
  'Gaming',
  'Movies',
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

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt1.jpeg")),
    filename: "matt1.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'Coffee to go! #onthejon'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon1.jpg")),
    filename: "simon1.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Wheels in motion, heart full of joy'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha1.jpg")),
    filename: "yasha1.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'School trips are a blast with you guys!'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt2.jpeg")),
    filename: "matt2.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'Drink responsibly kids'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon2.jpg")),
    filename: "simon2.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Wrapped in love, held in my heart'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha2.jpg")),
    filename: "yasha2.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'Date night with wifey'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt3.jpeg")),
    filename: "matt3.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'My dog! Kaptein! in his birthday suit. #standingonbusiness'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon3.jpg")),
    filename: "simon3.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Standing tall and proud, our little superstar is growing up!'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha3.jpg")),
    filename: "yasha3.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: '10/10/20'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt4.jpeg")),
    filename: "matt4.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'How many cameras do you count? One for every occasion.'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon4.jpg")),
    filename: "simon4.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Shaded souls, sunny hearts, and a low that is always in focus'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha4.jpg")),
    filename: "yasha4.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'Life is such a drag man...'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt5.jpeg")),
    filename: "matt5.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'Viper green Turbo s baby. Green with envy!'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon5.jpg")),
    filename: "simon5.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Where the road takes us, elegance follows...'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha5.jpg")),
    filename: "yasha5.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'My gran is better than yours!'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt6.jpeg")),
    filename: "matt6.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'Sunday morning walks in Hermanus, a personal fav.'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon6.jpg")),
    filename: "simon6.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Helping hands and a loving touch'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha7.jpg")),
    filename: "yasha7.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'Friday night tennis is the perfect end to a week...'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt7.jpeg")),
    filename: "matt7.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'Just a random mirror selfie'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon7.jpg")),
    filename: "simon7.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Besties for life: sharing smiles, secrets, and so much more'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha8.jpg")),
    filename: "yasha8.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'Mornings with my homie!'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt8.jpeg")),
    filename: "matt8.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'A trip down memoery lane. Whipped out the PSP! Juiced 2!'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon8.jpg")),
    filename: "simon8.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: yasha,
    content: 'Our greatest adventure begins...little one on board'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/yasha9.jpg")),
    filename: "yasha9.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'My mini me'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt9.jpeg")),
    filename: "matt9.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'No filter. Cotton candy skies.'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon9.jpg")),
    filename: "simon9.jpg",
    content_type: "image/jpg"
  )

  post = Post.create!(
    user: matt,
    content: 'Someone is a little jealous'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/matt10.jpeg")),
    filename: "matt10.jpeg",
    content_type: "image/jpeg"
  )

  post = Post.create!(
    user: simon,
    content: 'Ice cream with bae.'
  )

  post.photo.attach(
    io: File.open(Rails.root.join("app/assets/images/simon10.jpg")),
    filename: "simon10.jpg",
    content_type: "image/jpg"
  )

  puts "Finished creating posts."

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
