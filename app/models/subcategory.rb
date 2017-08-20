class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products
  validates_uniqueness_of :name, scope: :category_id
end
