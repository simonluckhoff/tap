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
puts "Clearing old data..."
Follow.destroy_all
Like.destroy_all
Share.destroy_all
PostInterest.destroy_all
UserInterest.destroy_all
Post.destroy_all
Interest.destroy_all
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
  'Books'
].map do |title|
  Interest.create!(
    title: title,
    # description: "All about #{title.downcase}"
  )
end

# Create users
puts "Creating users..."
users = []
10.times do |i|
  users << User.create!(
    email: "user#{i+1}@example.com",
    password: 'password123',
    username: "user#{i+1}",
    bio: "Bio for user #{i+1}"
  )
end

# # Create an admin user
# admin = User.create!(
#   email: 'admin@example.com',
#   password: 'password123',
#   username: 'admin',
#   bio: 'Admin user'
# )

# Create posts
puts "Creating posts..."
users.each do |user|
  3.times do |i|
    Post.create!(
      user: user,
      content: "This is post #{i+1} from #{user.username}. ##{interests.sample.title}"
    )
  end
end

# Create follows
puts "Creating follows..."
users.each do |user|
  # Each user follows 3 random users
  (users - [user]).sample(3).each do |user_to_follow|
    Follow.create!(
      follower: user,
      following: user_to_follow
    )
  end
end

# Create likes
puts "Creating likes..."
posts = Post.all
users.each do |user|
  # Each user likes 5 random posts
  posts.sample(5).each do |post|
    Like.create!(
      user: user,
      post: post
    )
  end
end

# Create shares
puts "Creating shares..."
users.each do |user|
  # Each user shares 2 random posts
  posts.sample(2).each do |post|
    Share.create!(
      user: user,
      post: post,
    )
  end
end

# Assign interests to users
puts "Creating user interests..."
users.each do |user|
  # Each user follows 3 random interests
  interests.sample(3).each do |interest|
    UserInterest.create!(
      user: user,
      interest: interest
    )
  end
end

# Assign interests to posts
puts "Creating post interests..."
posts.each do |post|
  # Each post gets 1-2 random interests
  interests.sample(rand(1..2)).each do |interest|
    PostInterest.create!(
      post: post,
      interest: interest
    )
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
