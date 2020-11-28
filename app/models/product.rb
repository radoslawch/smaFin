# frozen_string_literal: true

# Validator for a subcategory.
class ProductValidator < ActiveModel::Validator
  def validate(record)
    # check if product is in subcategory that is in category that belongs to current user
    if record.subcategory.nil? || record.subcategory.category.nil? ||
       record.subcategory.category.user_id != record.current_user_id
      record.errors[:category] << ' of subcategory of product must belong to current user'
    end
  end
end

# Model for a subcategory.
class Product < ApplicationRecord
  # so it's possible to validate that subcategory was added to category that belongs to the current user
  attr_accessor :current_user_id

  belongs_to :subcategory
  has_many :purchases

  validates_uniqueness_of :name, scope: :subcategory_id, case_sensitive: false
  validates :name, length: { in: 1..255 }
  validates :subcategory_id, length: { minimum: 1 }
  validates_presence_of :subcategory_id
  validates_with ProductValidator

  # a method for SubategoriesController for cascade hide
  def hide(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where("product_id=#{id}")
    purchases.each do |purchase|
      purchase.hide(current_user_id)
    end

    self.hidden = true
    save
  end

  # a method for SubategoriesController for cascade unhide
  def unhide(current_user_id)
    self.current_user_id = current_user_id
    Subcategory.find(subcategory_id).unhide(current_user_id)
    self.hidden = false
    save
  end

  # a method for SubcategoriesController for cascade destroy
  def destroy_cascade(current_user_id)
    self.current_user_id = current_user_id
    purchases = Purchase.where("product_id=#{id}")
    purchases.each do |purchase|
      purchase.destroy_cascade(current_user_id)
    end
    destroy
  end
end
