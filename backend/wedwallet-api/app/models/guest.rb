class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :wedding

  validates :user_id, :wedding_id, presence: true
end
