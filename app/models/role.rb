# frozen_string_literal: true

# Model for a role.
class Role < ApplicationRecord
  belongs_to :user

  validates_presence_of :controller_name
  validates_presence_of :action_name
  validates_presence_of :user_id
end
