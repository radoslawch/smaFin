# frozen_string_literal: true

require 'test_helper'

# model tests for category
class CategoryTest < ActiveSupport::TestCase
  setup do
    @u_id = User.first.id
  end

  test 'the truth' do
    assert true
  end

  test 'Category with no user and no name' do
    c = Category.new
    assert c.invalid?
  end

  test 'Category with bad user and no name' do
    c = Category.new
    c.user_id = -1
    assert c.invalid?
  end

  test 'Category with not existing user and no name' do
    c = Category.new
    c.user_id = 1_000_000
    assert c.invalid?
  end

  test 'Category with an other user and a name' do
    c = Category.new
    c.user_id = @u_id
    c.current_user_id = @u_id + 1
    c.name = 'name'
    assert c.invalid?
  end

  test 'Category with a user and a name' do
    c = Category.new
    c.user_id = @u_id
    c.current_user_id = @u_id
    c.name = 'name'
    assert c.valid?
  end

  test 'same Category for an other user' do
    c = Category.new
    c.user_id = @u_id + 1
    c.current_user_id = @u_id + 1
    c.name = 'name'
    assert c.valid?
  end

  test 'same Category for same user' do
    c = Category.new
    c.user_id = @u_id
    c.current_user_id = @u_id
    c.name = 'name'
    c.save!
    assert c.valid?

    c2 = Category.new
    c2.user_id = @u_id
    c2.current_user_id = @u_id
    c2.name = 'name'
    assert c2.invalid?
  end

  test 'Category with a long name and too long name' do
    c = Category.new
    c.user_id = @u_id
    c.current_user_id = @u_id
    c.name = ''
    255.times { c.name += 'a' }
    assert c.valid?

    c.name += 'a'
    assert c.invalid?
  end
end
