# frozen_string_literal: true

# Model for a user.
class User < ApplicationRecord
  has_many :categories
  has_many :carts
  has_many :roles
  validates_uniqueness_of :name, case_sensitive: false
end
