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
    
    puts "bad login test"
    post "/login", params: { user: "", password: "" }
    assert_redirected_to "/login"
    follow_redirect!
    
    puts "controller test after bad login"
    get carts_url
    assert_redirected_to "/login"
    follow_redirect!
    
    puts "good login test"
    post "/login", params: { user: "admin", password: "admin" }
    assert_redirected_to "/"
    follow_redirect!
    
    
    get carts_url, params: { cart: {  } }
    assert_redirected_to carts_url
    follow_redirect!
    
  end
  
  
end
