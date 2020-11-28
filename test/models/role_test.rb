# frozen_string_literal: true

require 'test_helper'

# model tests for roles
class RoleTest < ActiveSupport::TestCase
  test 'the truth' do
    assert true
  end

  test 'should add role' do
    r = Role.new
    r.user_id = users(:one).id
    r.name = 'name'
    r.valid?
  end

  test 'should not add role with no user' do
    r = Role.new
    r.name = 'name'
    r.invalid?
  end

  test 'should not add role with no name' do
    r = Role.new
    r.user_id = users(:one).id
    r.invalid?
  end
end
