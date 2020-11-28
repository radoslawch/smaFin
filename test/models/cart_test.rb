# frozen_string_literal: true

require 'test_helper'

# model tests for cart
class CartTest < ActiveSupport::TestCase
  setup do
    @u_id = User.first.id
  end

  test 'the truth' do
    assert true
  end

  test 'Cart with no user and no name' do
    c = Cart.new
    assert c.invalid?
  end

  test 'Cart with bad user and no name' do
    c = Cart.new
    c.user_id = -1
    assert c.invalid?
  end

  test 'Cart with not existing user and no name' do
    c = Cart.new
    c.user_id = 1_000_000
    assert c.invalid?
  end

  test 'Cart with an other user and a name' do
    c = Cart.new
    c.user_id = @u_id
    c.current_user_id = @u_id + 1
    c.name = 'name'
    assert c.invalid?
  end

  test 'Cart with a user and a name' do
    c = Cart.new
    c.user_id = @u_id
    c.current_user_id = @u_id
    c.name = 'name'
    assert c.valid?
  end

  test 'same Cart for an other user' do
    c = Cart.new
    c.user_id = @u_id + 1
    c.current_user_id = @u_id + 1
    c.name = 'name'
    assert c.valid?
  end

  test 'same Cart for same user' do
    c = Cart.new
    c.user_id = @u_id
    c.current_user_id = @u_id
    c.name = 'name'
    c.save!
    assert c.valid?

    c2 = Cart.new
    c2.user_id = @u_id
    c2.current_user_id = @u_id
    c2.name = 'name'
    assert c2.invalid?
  end

  test 'Cart with a long name and too long name' do
    c = Cart.new
    c.user_id = @u_id
    c.current_user_id = @u_id
    c.name = ''
    255.times { c.name += 'a' }
    assert c.valid?

    c.name += 'a'
    assert c.invalid?
  end
end
