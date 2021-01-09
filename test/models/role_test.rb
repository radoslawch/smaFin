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
    r.controller_name = 'name'
    r.action_name = 'name'
    r.valid?
  end

  test 'should not add role with no user' do
    r = Role.new
    r.controller_name = 'name'
    r.action_name = 'name'
    r.invalid?
  end

  test 'should not add role with no action name' do
    r = Role.new
    r.user_id = users(:one).id
    r.controller_name = 'name'
    r.invalid?
  end

  test 'should not add role with no controller name' do
    r = Role.new
    r.user_id = users(:one).id
    r.action_name = 'name'
    r.invalid?
  end
end
