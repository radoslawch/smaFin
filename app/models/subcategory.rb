class SubcategoryValidator < ActiveModel::Validator
  def validate(record)
    # check if subcategory is in category that belongs to current user
    if (record.category.user_id != record.current_user_id) then
      record.errors[:category] << " of subcategory must belong to current user"
    end
  end
end

class Subcategory < ApplicationRecord
  attr_accessor :current_user_id # so it's possible to validate that subcategory was added to category that belongs to the current user
  
  belongs_to :category
  has_many :products
  
  validates_uniqueness_of :name, scope: :category_id
  validates :name, length: { in: 1..255 }
  validates :category_id, length: { minimum: 1 }
  validates_presence_of :category_id
  validates_with SubcategoryValidator
  
  # a method for CategoriesController for cascade hide
  def hide(current_user_id)
    self.current_user_id = current_user_id
    products = Product.where("subcategory_id = " + self.id.to_s)
    if products.length > 0
      for product in products do
        product.hide(current_user_id)
      end
    end
    
    self.hidden = true
    self.save
  end   
  
  # a method for CategoriesController for cascade unhide
  def unhide(current_user_id)
    self.current_user_id = current_user_id
    products = Product.where("subcategory_id = " + self.id.to_s)
    if products.length > 0
      for product in products do
        product.hide(current_user_id)
      end
    end
    
    self.hidden = false
    self.save
  end  
end


