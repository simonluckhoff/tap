class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  after_commit :process_photo, on: :create
  # Posts associations
  # has_many :posts, dependent: :destroy


  # Likes associations
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # Shares associations
  has_many :shares, dependent: :destroy
  has_many :shared_posts, through: :shares, source: :post

  # Follow associations
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :followed_users, source: :following

  has_many :following_users, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :following_users, source: :follower

  has_many :comments, dependent: :destroy

  # Interests associations
  # has_many :user_interests, dependent: :destroy
  # has_many :interests, through: :user_interests

  has_many :post_interests, dependent: :destroy
  has_many :interests, through: :post_interests

  accepts_nested_attributes_for :post_interests

  private

  def process_photo
    PhotoProcessingJob.perform_later(self.id) if photo.attached?
  end
end
