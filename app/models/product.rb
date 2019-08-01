class ProductValidator < ActiveModel::Validator
  def validate(record)
    # check if product is in subcategory that is in category that belongs to current user
    if (record.subcategory.nil? || record.subcategory.category.nil? ||
    record.subcategory.category.user_id != record.current_user_id) then
      record.errors[:category] << " of subcategory of product must belong to current user"
    end
  end
end

class Product < ApplicationRecord
  attr_accessor :current_user_id # so it's possible to validate that subcategory was added to category that belongs to the current user
  
  belongs_to :subcategory
  has_many :purchases
  
  validates_uniqueness_of :name, scope: :subcategory_id  
  validates :name, length: { in: 1..255 }
  validates :subcategory_id, length: { minimum: 1 }
  validates_presence_of :subcategory_id
  validates_with ProductValidator
  
  # a method for SubategoriesController for cascade hide
  def hide(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where("product_id = " + self.id.to_s)
    if purchases.length > 0
      for purchase in purchases do
        purchase.hide(current_user_id)
      end
    end
    
    self.hidden = true
    self.save
  end   
  
  # a method for SubategoriesController for cascade unhide
  def unhide(current_user_id)
    self.current_user_id = current_user_id
    # bad logic: unhiding product should unhide subcategory
    # purchases = Purchase.where("product_id = " + self.id.to_s)
    # if purchases.length > 0
      # for purchase in purchases do
        # purchase.unhide(current_user_id)
      # end
    # end
    Subcategory.find(self.subcategory_id).unhide(current_user_id)
    
    
    self.hidden = false
    self.save
  end

  # a method for SubategoriesController for cascade destroy
  def destroy_cascade(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where("product_id = " + self.id.to_s)
    if purchases.length > 0
      for purchase in purchases do
        purchase.destroy_cascade(current_user_id)
      end
    end
    self.destroy
  end 
  
end
