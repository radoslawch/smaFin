# frozen_string_literal: true

require 'test_helper'

# model tests for user
class UserTest < ActiveSupport::TestCase
  test 'the truth' do
    assert true
  end

  test 'should add user' do
    u = User.new
    u.name = 'test'
    u.password_digest = BCrypt::Password.create('u')
    assert u.valid?
  end

  test 'should not add user with no name' do
    u = User.new
    assert u.invalid?
  end

  test 'should not add user with too long name' do
    u = User.new
    u.name = ''
    25.times { u.name += 'a' }
    assert u.invalid?
  end

  test 'should not add two users with same name' do
    u2 = User.new
    u2.name = 'test'
    u2.password_digest = BCrypt::Password.create('u2')
    u2.save!

    u = User.new
    u.name = 'test'
    assert u.invalid?
  end
end
