class CartValidator < ActiveModel::Validator
  def validate(record)
    # check if subcategory is in category that belongs to current user
    if (record.user_id != record.current_user_id) then
      record.errors[:category] << " must belong to current user #{record.user_id}, #{record.current_user_id}"
    end
  end
end

class Cart < ApplicationRecord  
  attr_accessor :current_user_id # so it's possible to validate that subcategory was added to category that belongs to the current user

  belongs_to :user
  has_many :purchases
  
  validates_uniqueness_of :name, scope: :user_id
  validates :name, length: { in: 1..24 }
  validates :user_id, length: { minimum: 1 }
  validates_presence_of :user_id
  validates_with CartValidator
    
  def hide(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where("cart_id = " + self.id.to_s)
    if purchases.length > 0
      for purchase in purchases do
        purchase.hide(current_user_id)
      end
    end
    
    self.hidden = true
    self.save
  end 
    
  def unhide(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where("cart_id = " + self.id.to_s)
    if purchases.length > 0
      for purchase in purchases do
        purchase.unhide(current_user_id)
      end
    end
    
    self.hidden = false
    self.save
  end 
    
end
