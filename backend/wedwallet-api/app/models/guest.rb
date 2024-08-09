class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :wedding

  validates :user_id, :wedding_id, presence: true
  validates :rsvp_status, inclusion: { in: %w[pending yes no], message: "%{value} is not a valid RSVP status" }

  def rsvp(response)
    if %w[yes no].include?(response)
      update(rsvp_status: response)
    else
      errors.add(:rsvp_status, "Invalid RSVP response")
      false
    end
  end
end