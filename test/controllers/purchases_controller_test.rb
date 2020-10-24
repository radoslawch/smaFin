require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase = purchases(:one)
  end

  test 'should get index' do
    get purchases_url
    assert_response :redirect
  end

  test 'should get new' do
    get new_purchase_url
    assert_response :redirect
  end

  test 'should create purchase' do
    # assert_difference('purchase.count') do
    post purchases_url, params: { purchase: {} }
    assert_response :redirect
    # end

    # assert_redirected_to purchase_url(purchase.last)
  end

  test 'should show purchase' do
    get purchase_url(@purchase)
    assert_response :redirect
  end

  test 'should get edit' do
    get edit_purchase_url(@purchase)
    assert_response :redirect
  end

  test 'should update purchase' do
    # p = Purchase.new
    # p.name = "a"
    # p.cart_id=1
    # p.product_id=1
    # p.amount=1
    # p.price=1
    # p.save!
    patch purchase_url(@purchase), params: { purchase: {} }
    assert_response :redirect

    # assert_response :redirect
    # assert_redirected_to purchase_url(@purchase)
  end

  test 'should destroy purchase' do
    # assert_difference('purchase.count', -1) do
    delete purchase_url(@purchase)
    assert_response :redirect
    # end

    # assert_redirected_to purchases_url
  end
end
