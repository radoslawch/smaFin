# frozen_string_literal: true

# Model for a role.
class Role < ApplicationRecord
  belongs_to :user
end
