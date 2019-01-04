class Cart < ApplicationRecord
    has_many :purchases
    belongs_to :user
    validates :name, length: { in: 1..24 }
    
end
