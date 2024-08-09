class User < ApplicationRecord
    has_secure_password
  
    validates :first_name, :last_name, :username, :email, presence: true
    validates :email, :username, uniqueness: true
  
    # Relationships
    has_many :hosts, dependent: :destroy
    has_many :weddings, through: :hosts
    has_many :guests, dependent: :destroy
    has_many :sent_cards, class_name: 'Card', foreign_key: 'sender_id'
    has_many :received_cards, class_name: 'Card', foreign_key: 'recipient_id'
    has_many :sent_gifts, class_name: 'Gift', foreign_key: 'sender_id'
    has_many :received_gifts, class_name: 'Gift', foreign_key: 'recipient_id'
  end
  