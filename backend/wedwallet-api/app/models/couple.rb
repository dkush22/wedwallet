class Couple < ApplicationRecord
    belongs_to :partner1, class_name: 'User', foreign_key: 'partner1_id'
    belongs_to :partner2, class_name: 'User', foreign_key: 'partner2_id'
  
    validates :partner1_id, presence: true
    validates :partner2_id, presence: true
  end  