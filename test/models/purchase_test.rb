# frozen_string_literal: true

require 'test_helper'

# model tests for purchases
class PurchaseTest < ActiveSupport::TestCase
  setup do
    @p_id = products(:one).id
    @c_id = carts(:one).id
    @u_id = products(:one).subcategory.category.user_id

    @p2_id = products(:two).id
    @c2_id = carts(:two).id
    @u2_id = products(:two).subcategory.category.user_id
  end

  test 'the truth' do
    assert true
  end

  def good_product
    p = Purchase.new
    p.name = 'name'
    p.price = 12.34
    p.amount = 2.5
    p.product_id = @p_id
    p.cart_id = @c_id

    p.current_user_id = @u_id
    p
  end

  test 'should create good purchase' do
    p = good_product
    assert p.valid?
  end

  test 'should not create purchase with no name' do
    p = good_product
    p.name = nil
    assert p.invalid?
  end

  test 'should not create purchase with too long name' do
    p = good_product
    p.name = 'a '
    255.times { p.name += 'a' }
    assert p.invalid?
  end

  test 'should not create purchase with no price' do
    p = good_product
    p.price = nil
    assert p.invalid?
  end

  test 'should not create purchase with too long price' do
    p = good_product
    p.price = 12_345_678_901_234_567_890.1234567890
    # should be saved in shorter format and thus be valid
    assert p.valid?
  end

  test 'should not create purchase with no amount' do
    p = good_product
    p.amount = nil
    assert p.invalid?
  end

  test 'should not create purchase with too long amount' do
    p = good_product
    p.amount = 12_345_678_901_234_567_890.1234567890
    # should be saved in shorter format and thus be valid
    assert p.valid?
  end

  test 'should not create purchase with no product' do
    p = good_product
    p.product_id = nil
    assert p.invalid?
  end

  test 'should not create purchase with no cart' do
    p = good_product
    p.cart_id = nil
    assert p.invalid?
  end

  test 'should not create purchase same name as another in same cart' do
    p0 = good_product
    p0.save!
    p = good_product
    p.product_id = @p2_id
    assert p.invalid?
  end

  test 'should create purchase same name as another in another cart' do
    p0 = good_product
    p0.save!
    p = good_product
    p.cart_id = carts(:one_2).id
    assert p.valid?
  end

  test 'should not create purchase in another user\' cart' do
    p = good_product
    p.cart_id = carts(:two).id
    assert p.invalid?
  end
end
