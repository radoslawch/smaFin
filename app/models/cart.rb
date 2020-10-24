class CartValidator < ActiveModel::Validator
  def validate(record)
    # check if cart belongs to current user
    record.errors[:cart] << ' must belong to current user' if record.user_id != record.current_user_id
  end
end

class Cart < ApplicationRecord
  attr_accessor :current_user_id # so it's possible to validate that subcategory was added to category that belongs to the current user

  belongs_to :user
  has_many :purchases

  validates_uniqueness_of :name, scope: :user_id
  validates :name, length: { in: 1..255 }
  validates :user_id, length: { minimum: 1 }
  validates_presence_of :user_id
  validates_with CartValidator

  def hide(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where('cart_id = ' + id.to_s)
    if purchases.length > 0
      purchases.each do |purchase|
        purchase.hide(current_user_id)
      end
    end

    self.hidden = true
    save
  end

  def unhide(current_user_id)
    self.current_user_id = current_user_id
    # bad logic: unhiding cart shouldn't unhide anything
    # purchases = Purchase.where("cart_id = " + self.id.to_s)
    # if purchases.length > 0
    # for purchase in purchases do
    # purchase.unhide(current_user_id)
    # end
    # end

    self.hidden = false
    save
  end

  def destroy_cascade(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where('cart_id = ' + id.to_s)
    if purchases.length > 0
      purchases.each do |purchase|
        purchase.destroy_cascade(current_user_id)
      end
    end
    destroy
  end
end
