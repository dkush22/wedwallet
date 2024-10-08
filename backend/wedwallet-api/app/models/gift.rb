class Gift < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :wedding

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
