# frozen_string_literal: true

require 'test_helper'

# model tests for subcategory
class SubcategoryTest < ActiveSupport::TestCase
  setup do
    @s_id = categories(:one).id
    @u_id = categories(:one).user_id
    @s2_id = categories(:two).id
    @u2_id = categories(:two).user_id
  end

  test 'the truth' do
    assert true
  end

  test 'Subcategory with no user and no name' do
    s = Subcategory.new
    assert s.invalid?
  end

  test 'Subcategory with bad category and no name' do
    s = Subcategory.new
    s.category_id = -1
    assert s.invalid?
  end

  test 'Subcategory with not existing category and no name' do
    s = Subcategory.new
    s.category_id = 1_000_000
    assert s.invalid?
  end

  test 'Subcategory with an other user and a name' do
    s = Subcategory.new
    s.category_id = @s_id
    s.current_user_id = @u2_id
    s.name = 'name'
    assert s.invalid?
  end

  test 'Subcategory with a user and a name' do
    s = Subcategory.new
    s.category_id = @s_id
    s.current_user_id = @u_id
    s.name = 'name'
    assert s.valid?
  end

  test 'same Subcategory for an other user' do
    s = Subcategory.new
    s.category_id = @s_id
    s.current_user_id = @u2_id
    s.name = 'name'
    assert s.invalid?
  end

  test 'same Category for same user' do
    s = Subcategory.new
    s.category_id = @s_id
    s.current_user_id = @u_id
    s.name = 'name'
    s.save!
    assert s.valid?

    s2 = Subcategory.new
    s2.category_id = @s_id
    s2.current_user_id = @u_id
    s2.name = 'name'
    assert s2.invalid?
  end

  test 'Category with a long name and too long name' do
    s = Subcategory.new
    s.category_id = @s_id
    s.current_user_id = @u_id
    s.name = ''
    255.times { s.name += 'a' }
    assert s.valid?

    s.name += 'a'
    assert s.invalid?
  end
end
