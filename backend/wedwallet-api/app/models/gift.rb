class Gift < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :wedding

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
