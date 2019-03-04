class CategoryValidator < ActiveModel::Validator
  def validate(record)
    # check if subcategory is in category that belongs to current user
    if (record.user_id != record.current_user_id) then
      record.errors[:category] << " must belong to current user #{record.user_id}, #{record.current_user_id}"
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
end
