class Wedding < ApplicationRecord
  belongs_to :primary_host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :secondary_host, class_name: 'User', foreign_key: 'second_host_id', optional: true
  has_many :guests
  has_many :attendees, through: :guests, source: :user
  has_many :cards
  has_many :gifts

  validates :title, :date, :location, presence: true

  def self.create_with_host(user, attributes)
    wedding = Wedding.new(attributes)
    
    if wedding.save
      # Once the wedding is saved, create the host
      host = Host.create(user: user, wedding: wedding)
      if host.persisted?
        wedding
      else
        wedding.destroy # Roll back the wedding if the host can't be created
        host.errors.full_messages
      end
    else
      wedding.errors.full_messages
    end
  end
end
