# frozen_string_literal: true

require 'test_helper'

# model tests for product
class ProductTest < ActiveSupport::TestCase
  setup do
    @s_id = subcategories(:one).id
    @c_id = subcategories(:one).category_id
    @u_id = Category.find(@c_id).user_id
    @s2_id = subcategories(:two).id
    @c2_id = subcategories(:two).category_id
    @u2_id = Category.find(@c2_id).user_id
  end

  test 'the truth' do
    assert true
  end

  test 'Product with no user and no name' do
    p = Product.new
    assert p.invalid?
  end

  test 'Product with bad subcategory and no name' do
    p = Product.new
    p.subcategory_id = -1
    assert p.invalid?
  end

  test 'Product with not existing subcategory and no name' do
    p = Product.new
    p.subcategory_id = 1_000_000
    assert p.invalid?
  end

  test 'Product with an other subcategory and a name' do
    p = Product.new
    p.subcategory_id = @s_id
    p.current_user_id = @u2_id
    p.name = 'name'
    assert p.invalid?
  end

  test 'Product with a user and a name' do
    p = Product.new
    p.subcategory_id = @s_id
    p.current_user_id = @u_id
    p.name = 'name'
    assert p.valid?
  end

  test 'same Product for an other user' do
    p = Product.new
    p.subcategory_id = @s2_id
    p.current_user_id = @u2_id
    p.name = 'name'
    assert p.valid?
  end

  test 'same Product for same user' do
    p = Product.new
    p.subcategory_id = @s_id
    p.current_user_id = @u_id
    p.name = 'name'
    p.save!
    assert p.valid?

    p2 = Product.new
    p2.subcategory_id = @s_id
    p2.current_user_id = @u_id
    p2.name = 'name'
    assert p2.invalid?
  end

  test 'Product with a long name and too long name' do
    p = Product.new
    p.subcategory_id = @s_id
    p.current_user_id = @u_id
    p.name = ''
    255.times { p.name += 'a' }
    assert p.valid?

    p.name += 'a'
    assert p.invalid?
  end
end
