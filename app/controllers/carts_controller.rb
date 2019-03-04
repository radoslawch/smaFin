class CartsController < ApplicationController

# cart list
  def index
    check_permission
    # get carts for logged user
    @carts = Cart.where("user_id =" + cookies.signed[:login_id].to_s)
  end

# show a cart
  def show 
    check_permission
    # to show chosen cart
    @cart = Cart.find(params[:id]) 
    # which contains some purchases
    @purchases = Purchase.left_joins(:cart).where("cart_id =" + params[:id] + " and user_id =" + cookies.signed[:login_id].to_s)
    
    # to add next purchase easly
    @purchase = Purchase.new
    # to chose a product to add
    @products =  Product.left_joins(:subcategory => :category).where("user_id =" + cookies.signed[:login_id].to_s)
    # which has some category and subcategory
    @subcategories =  Subcategory.left_joins(:category).where("user_id =" + cookies.signed[:login_id].to_s)
    @categories =  Category.where("user_id =" + cookies.signed[:login_id].to_s)
  end

# new cart view
  def new
    check_permission
    @cart = Cart.new
  end

# edit a cart
  def edit
    check_permission
    @cart = Cart.find(params[:id])
  end

# create a cart (after new)
  def create
    check_permission
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart
    else
      render 'new'
    end
  end

# update a cart (after edit)
  def update
    check_permission
    @cart = Cart.find(params[:id])

    if @cart.update(cart_params)
      redirect_to @cart
    else
      render 'edit'
    end
  end

  
  def destroy
    check_permission
    @cart = Cart.find(params[:id])
    
    @purchases = Purchase.where("cart_id = " + @cart.id.to_s)
    
    if @purchases.length > 0 then
      for purchase in @purchases do
        purchase.destroy
      end
    end
    @cart.destroy

    redirect_to carts_path
  end

# hide a cart (mark as hidden)
  def hide
    check_permission
    @cart = Cart.find(params[:id])
    
    # method from a model
    @cart.hide(cookies.signed[:login_id])

    redirect_to carts_path
  end    
  
  def unhide
    check_permission
    @cart = Cart.find(params[:id])
    
    # method from a model
    @cart.unhide(cookies.signed[:login_id])

    redirect_to carts_path
  end  


  private    
  def cart_params
    # params.require(:cart).permit(:name, :created, "dupa",   :user_id => [cookies.signed[:login_id].to_s]) 
    # params = ActionController::Parameters.new({
      # cart: {
        # name: @cart.name,
        # created:  @cart.created,
        # user_id: cookies.signed[:login_id]
      # }
    # })
   # params.require(:cart).permit(:name, :created, :user_id)
  params[:cart][:user_id] = cookies.signed[:login_id]
  params.require(:cart).permit(:name, :created, :user_id)
  end
end
