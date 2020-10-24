class SystemTest < ActionDispatch::IntegrationTest
  setup do
    @user_admin = users(:user_admin)
    part_no = 0
  end

  def add_stuff
    puts '----'
    puts 'category'
    puts '----'

    puts "go to categories' list"
    get categories_path
    assert :success

    puts 'go to new category'
    get new_category_path
    assert :success

    puts 'create new category'
    assert_difference('Category.count', 1) do
      assert_difference('Subcategory.count', 1) do
        post categories_path, params: { category: { name: 'category1' } }
      end
    end
    @category_last = Category.last
    assert_redirected_to category_url(@category_last)
    follow_redirect!

    puts 'go to category edit'
    get edit_category_path(@category_last)
    assert :success

    puts 'edit the category badly'
    patch category_url(@category_last), params: { category: { name: '' } }
    assert :success

    puts 'edit the category'
    patch category_url(@category_last), params: { category: { name: 'category1_edited' } }
    assert_redirected_to category_url(@category_last)
    follow_redirect!

    puts '----'
    puts 'subcategory'
    puts '----'

    puts 'go to new subcategory'
    get new_subcategory_path
    assert :success

    puts 'create new subcategory'
    assert_difference('Subcategory.count', 1) do
      post subcategories_path, params: { subcategory: { name: 'subcategory1', category_id: @category_last.id } }
    end
    @subcategory_last = Subcategory.last
    assert_redirected_to subcategory_url(@subcategory_last)
    follow_redirect!

    puts 'go to subcategory edit'
    get edit_subcategory_path(@subcategory_last)
    assert :success

    puts 'edit the subcategory badly'
    patch subcategory_url(@subcategory_last), params: { subcategory: { name: '' } }
    assert :success

    puts 'edit the subcategory badly 2nd'
    patch subcategory_url(@subcategory_last), params: { subcategory: { category_id: -1 } }
    assert :success

    puts 'edit the subcategory'
    patch subcategory_url(@subcategory_last), params: { subcategory: { name: 'subcategory1_edited' } }
    assert_redirected_to subcategory_url(@subcategory_last)
    follow_redirect!

    puts '----'
    puts 'product'
    puts '----'

    puts 'go to new product'
    get new_product_path
    assert :success

    puts 'create new product'
    assert_difference('Product.count', 1) do
      post products_path, params: { product: { name: 'products1', subcategory_id: @subcategory_last.id } }
    end
    @product_last = Product.last
    assert_redirected_to product_url(@product_last)
    follow_redirect!

    puts 'go to product edit'
    get edit_product_path(@product_last)
    assert :success

    puts 'edit the product badly'
    patch product_url(@product_last), params: { product: { name: '' } }
    assert :success

    puts 'edit the product badly 2nd'
    patch product_url(@product_last), params: { product: { subcategory_id: -1 } }
    assert :success

    puts 'edit the product'
    patch product_url(@product_last), params: { product: { name: 'product1_edited' } }
    assert_redirected_to product_url(@product_last)
    follow_redirect!

    puts '----'
    puts 'cart'
    puts '----'

    puts 'go to new cart'
    get new_cart_path
    assert :success

    puts 'create new cart'
    assert_difference('Cart.count', 1) do
      post carts_path, params: { cart: { name: 'cart1' } }
    end
    @cart_last = Cart.last
    assert_redirected_to cart_url(@cart_last)
    follow_redirect!

    puts 'go to cart edit'
    get edit_cart_path(@cart_last)
    assert :success

    puts 'edit the cart badly'
    patch cart_url(@cart_last), params: { cart: { name: '' } }
    assert :success

    puts 'edit the cart'
    patch cart_url(@cart_last), params: { cart: { name: 'cart1_edited' } }
    assert_redirected_to cart_url(@cart_last)
    follow_redirect!

    puts '----'
    puts 'purchase'
    puts '----'

    puts 'go to new purchase'
    get new_purchase_path
    assert :success

    puts 'create new purchase'
    assert_difference('Purchase.count', 1) do
      post purchases_path, params: { purchase: { name: 'purchase1', cart_id: @cart_last.id, product_id: @product_last.id, amount: 1, price: 2 } }
    end
    @purchase_last = Purchase.last
    assert_redirected_to cart_url(@purchase_last.cart)
    follow_redirect!

    puts 'go to purchase edit'
    get edit_purchase_path(@purchase_last)
    assert :success

    puts 'edit the purchase badly'
    patch purchase_url(@purchase_last), params: { purchase: { name: '' } }
    assert :success

    puts 'edit the purchase badly 2nd'
    patch purchase_url(@purchase_last), params: { purchase: { product_id: -1 } }
    assert :success

    puts 'edit the purchase badly 3rd'
    patch purchase_url(@purchase_last), params: { purchase: { cart_id: -1 } }
    assert :success

    puts 'edit the purchase'
    patch purchase_url(@purchase_last), params: { purchase: { name: 'purchase1_edited' } }
    assert_redirected_to cart_url(@purchase_last.cart)
    follow_redirect!
  end

  def sanity_test
    puts ''

    puts 'sanity test'

    post carts_url, params: { cart: {} }
    assert_response :redirect

    puts 'open root path'
    get root_path
    assert_redirected_to '/login'
    follow_redirect!

    puts 'bad login test'
    post '/login', params: { user: '', password: '' }
    assert_redirected_to '/login'
    follow_redirect!

    puts 'controller test after bad login'
    get carts_url
    assert_redirected_to '/login'
    follow_redirect!
  end

  test 'should get full test' do
    sanity_test

    puts '.'
    puts '.'
    puts '.'
    puts 'begin really full fully test'
    puts '.'
    puts '.'
    puts '.'

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '1. part'
    puts 'create a new user and try logging in as them'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'login as an admin'
    post '/login', params: { user: @user_admin.name, password: @user_admin.password }
    assert_redirected_to '/'
    follow_redirect!

    puts 'controller test after good login'
    get carts_url
    assert :success

    puts 'go to new user page'
    get new_user_url
    assert :success

    puts 'create new user'
    assert_difference('User.count', 1) do
      post users_url, params: { user: { name: 'user', password: 'password' } }
    end
    assert_redirected_to user_url(User.last)
    follow_redirect!

    puts 'logout'
    get logout_url
    assert_redirected_to root_path

    puts 'login as a new user (user should be redirected to login as he has no roles)'
    post '/login', params: { user: 'user', password: 'password' }
    assert_redirected_to '/'
    follow_redirect!
    assert_redirected_to application_no_permissions_path
    follow_redirect!

    puts 'logout'
    get logout_url
    assert_redirected_to root_path

    puts 'login as an admin again'
    post '/login', params: { user: 'admin', password: 'admin' }
    assert_redirected_to '/'
    follow_redirect!

    puts 'go to new role page'
    get new_role_url
    assert :success

    puts 'create new role'
    assert_difference('Role.count', 1) do
      post roles_url, params: { role: { name: '*', user_id: User.last.id } }
    end
    assert_redirected_to role_url(Role.last)
    follow_redirect!

    puts 'logout'
    get logout_url
    assert_redirected_to root_path

    puts 'login as a new user (user should be able to login now)'
    post '/login', params: { user: 'user', password: 'password' }
    assert_redirected_to '/'
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '2. part'
    puts 'create objects as a new user'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    add_stuff

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '3. part'
    puts 'delete all created objects'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'delete the purchase'
    assert_difference('Purchase.count', -1) do
      delete purchase_path(@purchase_last.id)
    end
    assert_redirected_to purchases_url
    follow_redirect!

    puts 'delete the cart'
    assert_difference('Cart.count', -1) do
      delete cart_path(@cart_last.id)
    end
    assert_redirected_to carts_url
    follow_redirect!

    puts 'delete the product'
    assert_difference('Product.count', -1) do
      delete product_path(@product_last.id)
    end
    assert_redirected_to products_url
    follow_redirect!

    puts 'delete the subcategory'
    assert_difference('Subcategory.count', -1) do
      delete subcategory_path(@subcategory_last.id)
    end
    assert_redirected_to subcategories_url
    follow_redirect!

    puts 'delete the category'
    assert_difference('Category.count', -1) do
      delete category_path(@category_last.id)
    end
    assert_redirected_to categories_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '4. part'
    puts 'create objects once again'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    add_stuff

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '5. part'
    puts 'delete only category and cart'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'delete the cart'
    assert_difference('Cart.count', -1) do
      delete cart_path(@cart_last.id)
    end
    assert_equal(0, Purchase.where("cart_id=#{@cart_last.id}").count)
    assert_redirected_to carts_url
    follow_redirect!

    puts 'delete the category'
    s_cats_before = Subcategory.where("category_id=#{@category_last.id}")
    s_cats_ids = s_cats_before.pluck(:id).to_s.gsub('[', '(').gsub(']', ')')
    assert_difference('Category.count', -1) do
      delete category_path(@category_last.id)
    end
    assert_equal(0, Subcategory.where("category_id=#{@category_last.id}").count)
    assert_equal(0, Product.where("subcategory_id IN #{s_cats_ids}").count)
    assert_redirected_to categories_url
    follow_redirect!
    s_cats_before = nil
    s_cats_ids = nil

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '6. part'
    puts 'create objects once-once again'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    add_stuff

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '7. part'
    puts 'delete only category and cart in reversed order'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'delete the category'
    s_cats_before = Subcategory.where("category_id=#{@category_last.id}")
    s_cats_ids = s_cats_before.pluck(:id).to_s.tr('[]', '()')
    prods_before = Product.where("subcategory_id IN #{s_cats_ids}")
    prods_before_ids = prods_before.pluck(:id).to_s.tr('[]', '()')

    assert_difference('Category.count', -1) do
      delete category_path(@category_last.id)
    end
    assert_equal(0, Subcategory.where("category_id=#{@category_last.id}").count)
    assert_equal(0, Product.where("subcategory_id IN #{s_cats_ids}").count)
    assert_equal(0, Purchase.where("product_id IN #{prods_before_ids}").count)
    assert_redirected_to categories_url
    follow_redirect!
    s_cats_before = nil
    s_cats_ids = nil
    prods_before = nil
    prods_before_ids = nil

    puts 'delete the cart'
    assert_difference('Cart.count', -1) do
      delete cart_path(@cart_last.id)
    end
    assert_redirected_to carts_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '8. part'
    puts 'create objects once-once-once again'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    add_stuff

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '9. part'
    puts 'hide objects one by one'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'hide the purchase'
    post hide_purchase_url(@purchase_last.id)
    assert_redirected_to cart_url(@purchase_last.cart)
    assert_equal(true, Purchase.find(@purchase_last.id).hidden)
    follow_redirect!

    puts 'hide the cart'
    post hide_cart_url(@cart_last.id)
    assert_equal(true, Cart.find(@cart_last.id).hidden)
    assert_redirected_to carts_url
    follow_redirect!

    puts 'hide the product'
    post hide_product_url(@product_last.id)
    assert_equal(true, Product.find(@product_last.id).hidden)
    assert_redirected_to products_url
    follow_redirect!

    puts 'hide the subcategory'
    post hide_subcategory_url(@subcategory_last.id)
    assert_equal(true, Subcategory.find(@subcategory_last.id).hidden)
    assert_redirected_to subcategories_url
    follow_redirect!

    puts 'hide the category'
    post hide_category_url(@category_last.id)
    assert_equal(true, Category.find(@category_last.id).hidden)
    assert_redirected_to categories_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '10. part'
    puts 'unhide objects one by one'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'unhide the purchase'
    post unhide_purchase_url(@purchase_last.id)
    assert_equal(false, Purchase.find(@purchase_last.id).hidden)
    assert_redirected_to cart_url(@purchase_last.cart)
    follow_redirect!

    puts 'unhide the cart'
    post unhide_cart_url(@cart_last.id)
    assert_equal(false, Cart.find(@cart_last.id).hidden)
    assert_redirected_to carts_url
    follow_redirect!

    puts 'unhide the product'
    post unhide_product_url(@product_last.id)
    assert_equal(false, Product.find(@product_last.id).hidden)
    assert_redirected_to products_url
    follow_redirect!

    puts 'unhide the subcategory'
    post unhide_subcategory_url(@subcategory_last.id)
    assert_equal(false, Subcategory.find(@subcategory_last.id).hidden)
    assert_redirected_to subcategories_url
    follow_redirect!

    puts 'unhide the category'
    post unhide_category_url(@category_last.id)
    assert_equal(false, Category.find(@category_last.id).hidden)
    assert_redirected_to categories_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '11. part'
    puts 'hide only category and cart'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'hide the cart'
    post hide_cart_url(@cart_last.id)
    assert_equal(true, Cart.find(@cart_last.id).hidden)
    assert_equal(0, Purchase.where("cart_id=#{@cart_last.id} AND hidden=0").count)
    assert_redirected_to carts_url
    follow_redirect!

    puts 'hide the category'
    post hide_category_url(@category_last.id)
    assert_equal(true, Category.find(@category_last.id).hidden)
    assert_equal(0, Subcategory.where("category_id=#{@category_last.id} AND hidden=0").count)
    assert_equal(0, Product.left_joins(:subcategory).where("category_id=#{@category_last.id} AND products.hidden=0").count)
    assert_redirected_to categories_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '12. part'
    puts 'unhide only category and cart'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'unhide the category'
    post unhide_category_url(@category_last.id)
    assert_equal(false, Category.find(@category_last.id).hidden)
    # others stay hidden
    assert_equal(0, Subcategory.where("category_id=#{@category_last.id} AND hidden=0").count)
    assert_equal(0, Product.left_joins(:subcategory).where("category_id=#{@category_last.id} AND products.hidden=0").count)
    assert_redirected_to categories_url
    follow_redirect!

    puts 'unhide the cart'
    post unhide_cart_url(@cart_last.id)
    assert_equal(false, Cart.find(@cart_last.id).hidden)
    # others stay hidden
    assert_equal(0, Purchase.where("cart_id=#{@cart_last.id} AND hidden=0").count)
    assert_redirected_to carts_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '13. part'
    puts 'hide only category and cart in reversed order'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'hide the category'
    post hide_category_url(@category_last.id)
    assert_equal(true, Category.find(@category_last.id).hidden)
    assert_equal(0, Subcategory.where("category_id=#{@category_last.id} AND subcategories.hidden=0").count)
    assert_equal(0, Product.left_joins(:subcategory).where("category_id=#{@category_last.id} AND products.hidden=0").count)
    assert_equal(0, Purchase.left_joins(product: :subcategory).where("category_id=#{@category_last.id} AND purchases.hidden=0").count)
    assert_redirected_to categories_url
    follow_redirect!

    puts 'hide the cart'
    post hide_cart_url(@cart_last.id)
    assert_equal(true, Cart.find(@cart_last.id).hidden)
    assert_redirected_to carts_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '14. part'
    puts 'unhide only category and cart in reversed order'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'unhide the cart'
    post unhide_cart_url(@cart_last.id)
    assert_equal(false, Cart.find(@cart_last.id).hidden)
    assert_equal(0, Purchase.where("cart_id=#{@cart_last.id} AND hidden=0").count)
    assert_redirected_to carts_url
    follow_redirect!

    puts 'unhide the category'
    post unhide_category_url(@category_last.id)
    assert_equal(false, Category.find(@category_last.id).hidden)
    assert_equal(0, Subcategory.where("category_id=#{@category_last.id} AND hidden=0").count)
    assert_equal(0, Product.left_joins(:subcategory).where("category_id=#{@category_last.id} AND products.hidden=0").count)
    assert_equal(0, Purchase.left_joins(product: :subcategory).where("category_id=#{@category_last.id} AND purchases.hidden=0").count)
    assert_redirected_to categories_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '15. part'
    puts 'hide only category and cart once again'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'hide the cart'
    post hide_cart_url(@cart_last.id)
    assert_equal(true, Cart.find(@cart_last.id).hidden)
    assert_equal(0, Purchase.where("cart_id=#{@cart_last.id} AND hidden=0").count)
    assert_redirected_to carts_url
    follow_redirect!

    puts 'hide the category'
    post hide_category_url(@category_last.id)
    assert_equal(true, Category.find(@category_last.id).hidden)
    assert_equal(0, Subcategory.where("category_id=#{@category_last.id} AND hidden=0").count)
    assert_equal(0, Product.left_joins(:subcategory).where("category_id=#{@category_last.id} AND products.hidden=0").count)
    assert_redirected_to categories_url
    follow_redirect!

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts '16. part'
    puts 'unhide only purchase'
    puts '-------------------------------------------------------------------------------------'
    puts ''

    puts 'unhide the purchase'
    post unhide_purchase_url(@purchase_last.id)
    # everything in the path should be now unhidden
    assert_equal(false, Cart.find(@purchase_last.cart_id).hidden)
    assert_equal(false, Product.find(@purchase_last.product_id).hidden)
    assert_equal(false, Subcategory.find(Product.find(@purchase_last.product_id).subcategory_id).hidden)
    assert_equal(false, Category.find(Subcategory.find(Product.find(@purchase_last.product_id).subcategory_id).category_id).hidden)
  end
end
