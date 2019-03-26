class PurchaseValidator < ActiveModel::Validator
  def validate(record)
    # check if purchase is a product that is in a subcategory that is in category that belongs to current user
    if record.product.nil? then
      record.errors[:product] << " must be chosen"
    elsif (record.product.subcategory.category.user_id != record.current_user_id) then
      record.errors[:category] << " of subcategory of product must belong to current user"
    end
    
    if record.cart.nil? then  
      record.errors[:cart] << " must be chosen"
    elsif (record.cart.user_id != record.current_user_id) then
      record.errors[:cart] << " must belong to current user"
    end
  end
end

class Purchase < ApplicationRecord
  attr_accessor :current_user_id # so it's possible to validate that subcategory was added to category that belongs to the current user

  belongs_to :product
  belongs_to :cart  
  
  validates_uniqueness_of :name, scope: :cart_id
  validates :name, length: { in: 1..255 }  
  validates :price, length: { in: 1..24 }  
  validates :amount, length: { in: 1..24 }  
  validates :product_id, length: { minimum: 1 }
  validates_presence_of :product_id
  validates_with PurchaseValidator  
  
  # a method for ProductController for cascade hide
  def hide(current_user_id)
    self.current_user_id = current_user_id
    
    self.hidden = true
    self.save
  end   
  
  # a method for ProductController for cascade unhide
  def unhide(current_user_id)
    self.current_user_id = current_user_id

    self.hidden = false
    self.save
  end 
end
