class Interest < ApplicationRecord
  has_many :user_interests, dependent: :destroy
  has_many :users, through: :user_interests

  has_many :post_interests, dependent: :destroy
  has_many :posts, through: :post_interests

  validates :title, presence: true, uniqueness: true
end
