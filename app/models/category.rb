class CategoryValidator < ActiveModel::Validator
  def validate(record)
    # check if subcategory is in category that belongs to current user
    if (record.user_id != record.current_user_id) then
      record.errors[:category] << " must belong to current user"
    end
  end
end

class Category < ApplicationRecord
  attr_accessor :current_user_id # so it's possible to validate that subcategory was added to category that belongs to the current user
  
  belongs_to :user
  has_many :subcategories
  
  validates_uniqueness_of :name, scope: :user_id
  validates :name, length: { in: 1..255 }
  validates :user_id, length: { minimum: 1 }
  validates_presence_of :user_id
  validates_with CategoryValidator
  
  # a method for CategoriesController for cascade hide
  def hide(current_user_id)
    self.current_user_id = current_user_id
    subcategories = Subcategory.where("category_id = " + self.id.to_s)
    if subcategories.length > 0
      for subcategory in subcategories do
        subcategory.hide(current_user_id)
      end
    end
    
    self.hidden = true
    self.save
  end   
  
  # a method for CategoriesController for cascade unhide
  def unhide(current_user_id)
    self.current_user_id = current_user_id
    # bad logic: unhiding a category shouldn't unhide anything
    # subcategories = Subcategory.where("category_id = " + self.id.to_s)
    # if subcategories.length > 0
      # for subcategory in subcategories do
        # subcategory.unhide(current_user_id)
      # end
    # end
    
    self.hidden = false
    self.save
  end     
  
  # a method for CategoriesController for cascade destroy
  def destroy_cascade(current_user_id)
    self.current_user_id = current_user_id
    subcategories = Subcategory.where("category_id = " + self.id.to_s)
    if subcategories.length > 0
      for subcategory in subcategories do
        subcategory.destroy_cascade(current_user_id)
      end
    end
    self.destroy
  end 
  
end
