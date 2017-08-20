class Product < ApplicationRecord
  belongs_to :subcategory
  has_many :purchases
  validates_uniqueness_of :name, scope: :subcategory_id
end
