class SystemTest < ActionDispatch::IntegrationTest

  setup do
    #@cart = carts(:one)
  end
  
  test "should get full test" do
    puts ""
    
    puts "sanity test"
    
    post carts_url, params: { cart: {  } }
    assert_response :redirect
    
    puts "open root path"
    get root_path
    assert_redirected_to "/login"
    follow_redirect!
    
    puts "login test"
    post "/login", params: { user: "admins", password: "admin" }
    assert_response :redirect
    
    
    post carts_url, params: { cart: {  } }
    assert_response :redirect
  end
  
  
end
