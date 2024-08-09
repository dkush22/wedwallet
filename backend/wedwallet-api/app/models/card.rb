class Card < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :wedding

  validates :message, :card_type, presence: true

  # Enum for card types
  enum card_type: { wedding_card: 'wedding', thank_you_card: 'thank_you' }

  # Handle file uploads for photo and video (assuming you use something like ActiveStorage)
  has_one_attached :photo
  has_one_attached :video
end
