require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
  end

  test 'should get index' do
    get categories_url
    assert_response :redirect
  end

  test 'should get new' do
    get new_category_url
    assert_response :redirect
  end

  test 'should create category' do
    # assert_difference('category.count') do
    post categories_url, params: { category: {} }
    assert_response :redirect
    # end

    # assert_redirected_to category_url(category.last)
  end

  test 'should show category' do
    get category_url(@category)
    assert_response :redirect
  end

  test 'should get edit' do
    get edit_category_url(@category)
    assert_response :redirect
  end

  test 'should update category' do
    patch category_url(@category), params: { category: {} }
    assert_response :redirect

    # assert_response :redirect
    # assert_redirected_to category_url(@category)
  end

  test 'should destroy category' do
    # assert_difference('category.count', -1) do
    delete category_url(@category)
    assert_response :redirect
    # end

    # assert_redirected_to categories_url
  end
end
