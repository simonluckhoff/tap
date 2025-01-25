class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :following_id }
  validate :not_following_self

  private

  def not_following_self
    errors.add(:follower_id, "can't follow themselves") if follower_id == following_id
  end
end
