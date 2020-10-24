require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test 'should get index' do
    get carts_url
    assert_response :redirect
  end

  test 'should get new' do
    get new_cart_url
    assert_response :redirect
  end

  test 'should create cart' do
    # assert_difference('cart.count') do
    post carts_url, params: { cart: {} }
    assert_response :redirect
    # end

    # assert_redirected_to cart_url(cart.last)
  end

  test 'should show cart' do
    get cart_url(@cart)
    assert_response :redirect
  end

  test 'should get edit' do
    get edit_cart_url(@cart)
    assert_response :redirect
  end

  test 'should update cart' do
    patch cart_url(@cart), params: { cart: {} }
    assert_response :redirect

    # assert_response :redirect
    # assert_redirected_to cart_url(@cart)
  end

  test 'should destroy cart' do
    # assert_difference('cart.count', -1) do
    delete cart_url(@cart)
    assert_response :redirect
    # end

    # assert_redirected_to carts_url
  end
end
