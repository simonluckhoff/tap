class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  def profile_image_url
    if photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(photo, only_path: true)
    else
      '/assets/default_image.png'
    end
  end

  # Posts associations
  has_many :posts, dependent: :destroy

  # Likes associations
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # Shares associations
  has_many :shares, dependent: :destroy
  has_many :shared_posts, through: :shares, source: :post

  # Follow associations
  has_many :follower_associations, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_associations, source: :follower

  has_many :following_associations, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :following, through: :following_associations, source: :following

  # Interests associations
  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests

  has_many :comments, dependent: :destroy


  def follow(user)
    Follow.find_or_create_by(follower: self, following: user)
  end

  def unfollow(user)
    follow_record = Follow.find_by(follower: self, following: user)
    follow_record.destroy if follow_record
  end

  # Check if following a user
  def following?(user)
    following.include?(user)
  end

  include PgSearch::Model
  pg_search_scope :search_by_username,
    against: [:username ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
