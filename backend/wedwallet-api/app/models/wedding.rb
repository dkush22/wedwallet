class Wedding < ApplicationRecord
  has_many :hosts, dependent: :destroy
  has_many :users, through: :hosts

  has_many :guests, dependent: :destroy
  has_many :guest_users, through: :guests, source: :user

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
