class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  # chat

  # has_many :conversations_as_user1, class_name: "Conversation", foreign_key: :user1_id, dependent: :destroy
  # has_many :conversations_as_user2, class_name: "Conversation", foreign_key: :user2_id, dependent: :destroy

  # def conversations
  #   Conversation.where("user1_id = ? OR user2_id = ?", id, id)
  # end


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

end
