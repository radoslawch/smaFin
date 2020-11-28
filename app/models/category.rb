# frozen_string_literal: true

# Validator for a category.
class CategoryValidator < ActiveModel::Validator
  def validate(record)
    # check if subcategory is in category that belongs to current user
    record.errors[:category] << ' must belong to current user' if record.user_id != record.current_user_id
  end
end

# Model for a category.
class Category < ApplicationRecord
  # so it's possible to validate that subcategory was added to category that belongs to the current user
  attr_accessor :current_user_id

  belongs_to :user
  has_many :subcategories

  validates_uniqueness_of :name, scope: :user_id, case_sensitive: false
  validates :name, length: { in: 1..255 }
  validates :user_id, length: { minimum: 1 }
  validates_presence_of :user_id
  validates_with CategoryValidator

  # a method for CategoriesController for cascade hide
  def hide(current_user_id)
    self.current_user_id = current_user_id
    subcategories = Subcategory.where("category_id=#{id}")
    subcategories.each do |subcategory|
      subcategory.hide(current_user_id)
    end

    self.hidden = true
    save
  end

  # a method for CategoriesController for cascade unhide
  def unhide(current_user_id)
    self.current_user_id = current_user_id
    self.hidden = false
    save
  end

  # a method for CategoriesController for cascade destroy
  def destroy_cascade(current_user_id)
    self.current_user_id = current_user_id
    subcategories = Subcategory.where("category_id =#{id}")
    subcategories.each do |subcategory|
      subcategory.destroy_cascade(current_user_id)
    end
    destroy
  end
end
