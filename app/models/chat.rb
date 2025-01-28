class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy

  validates :sender, presence: true
  validates :recipient, presence: true

  # Ensure only one chat exists between two users
  validates :sender_id, uniqueness: { scope: :recipient_id }

  # Find or create a chat between two users
  def self.find_or_create_between(sender_id, recipient_id)
    find_or_create_by(sender_id: sender_id, recipient_id: recipient_id) do |chat|
      chat.sender_id = sender_id
      chat.recipient_id = recipient_id
    end
  end
end
