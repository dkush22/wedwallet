class AddRsvpStatusToGuests < ActiveRecord::Migration[6.0]
  def change
    add_column :guests, :rsvp_status, :string, default: "pending"
  end
end