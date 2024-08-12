# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'csv'

# Load Users

User.delete_all

CSV.foreach(Rails.root.join('db', 'users.csv'), headers: true) do |row|
    User.create!(

        id: row['id'],
        first_name: row['first_name'],
        last_name: row['last_name'],
        email: row['email'],
        password: row['password'],
    )
end

# Load Couples

Couple.delete_all

CSV.foreach(Rails.root.join('db', 'couples.csv'), headers: true) do |row|
    Couple.create!(

        partner1_id: row['partner1_id'],
        partner2_id: row['partner2_id']
    )
end

# Load Weddings

Wedding.delete_all

CSV.foreach(Rails.root.join('db', 'weddings.csv'), headers: true) do |row|
    Wedding.create!(
        
        id: row['id'],
        title: row['title'],
        date: DateTime.parse(row['date']),
        location: row['location'],
        host_id: row['host_id'],
    )
end

#Load Hosts

Host.delete_all

CSV.foreach(Rails.root.join('db', 'hosts.csv'), headers: true) do |row|
  Host.create!(

    user_id: row['user_id'],
    wedding_id: row['wedding_id']
  )
end

#Load Guests

Guest.delete_all

CSV.foreach(Rails.root.join('db', 'guests.csv'), headers: true) do |row|
  Guest.create!(

    user_id: row['user_id'],
    wedding_id: row['wedding_id'],
    rsvp_status: row['rsvp_status']
  )
end

# Load Gifts

Gift.delete_all

CSV.foreach(Rails.root.join('db', 'gifts.csv'), headers: true) do |row|
    Gift.create!(

        sender_id: row['sender_id'],
        recipient_id: row['recipient_id'],
        wedding_id: row['wedding_id'],
        amount: row['amount']
    )
end

# Load Cards

Card.delete_all

CSV.foreach(Rails.root.join('db', 'cards.csv'), headers: true) do |row|
    Card.create!(

        sender_id: row['sender_id'],
        recipient_id: row['recipient_id'],
        wedding_id: row['wedding_id'],
        message: row['message'],
        card_type: row['card_type']
    )
end
