class PostInterest < ApplicationRecord
  belongs_to :post
  belongs_to :interest

  validates :post_id, uniqueness: { scope: :interest_id }
end
