class User < ApplicationRecord
  has_secure_password


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
  # Relationships
  has_many :hosts, dependent: :destroy
  has_many :weddings, through: :hosts
  has_many :guests, dependent: :destroy
  has_many :sent_cards, class_name: 'Card', foreign_key: 'sender_id'
  has_many :received_cards, class_name: 'Card', foreign_key: 'recipient_id'
  has_many :sent_gifts, class_name: 'Gift', foreign_key: 'sender_id'
  has_many :received_gifts, class_name: 'Gift', foreign_key: 'recipient_id'
end
