class User < ApplicationRecord
    has_secure_password
  
    validates :first_name, :last_name, :username, :email, presence: true
    validates :email, :username, uniqueness: true
  
    # Relationships
    has_many :hosts, dependent: :destroy
    has_many :weddings, through: :hosts
    has_many :guests, dependent: :destroy
  end
  