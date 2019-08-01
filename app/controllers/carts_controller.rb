class CartsController < ApplicationController

# cart list
  def index
    if !check_permission then return end
    # get carts for logged user
    @carts = Cart.where("user_id =" + session[:login_id].to_s)
  end

# show a cart
  def show 
    if !check_permission then return end
    

    # to show chosen cart
    @cart = Cart.find(params[:id]) 
    # which contains some purchases
    @purchases = Purchase.left_joins(:cart).where("cart_id =" + params[:id] + " and user_id =" + session[:login_id].to_s)
    
    # to add next purchase easly
    @purchase = Purchase.new
    # to chose a product to add
    @products =  Product.left_joins(:subcategory => :category).where("user_id =" + session[:login_id].to_s)
    # which has some category and subcategory
    @subcategories =  Subcategory.left_joins(:category).where("user_id =" + session[:login_id].to_s)
    @categories =  Category.where("user_id =" + session[:login_id].to_s)
    
    @cant_add_purchase_reason = ""
    if @categories.length == 0 then
      @cant_add_purchase_reason = @cant_add_purchase_reason + "Add a category first! "
    end
    if @subcategories.length == 0 then
      @cant_add_purchase_reason = @cant_add_purchase_reason + "Add a subcategory first! "
    end
    if @products.length == 0 then
      @cant_add_purchase_reason = @cant_add_purchase_reason + "Add a product first! "
    end
    
    @cart.current_user_id = session[:login_id]
    if !@cart.valid?
      redirect_to carts_path, notice: @cart.errors.full_messages.join(', ')
    end
  end

# new cart view
  def new
    if !check_permission then return end
    @cart = Cart.new
  end

# edit a cart
  def edit
    if !check_permission then return end
    @cart = Cart.find(params[:id])
    
    @cart.current_user_id = session[:login_id]
    if !@cart.valid?
      redirect_to carts_path, notice: @cart.errors.full_messages.join(', ')
    end
  end

# create a cart (after new)
  def create
    if !check_permission then return end
    @cart = Cart.new(cart_params)
    @cart.current_user_id = session[:login_id]

    if @cart.save
      redirect_to @cart
    else
      render 'new'
    end
  end

# update a cart (after edit)
  def update
    if !check_permission then return end
    @cart = Cart.find(params[:id])
    @cart.current_user_id = session[:login_id]

    if @cart.update(cart_params)
      redirect_to @cart
    else
      render 'edit'
    end
  end

  
  def destroy
    if !check_permission then return end
    @cart = Cart.find(params[:id])
    @cart.destroy_cascade(session[:login_id])
    # @cart.destroy
    redirect_to carts_path
    
    # @cart = Cart.find(params[:id])
    
    # @purchases = Purchase.where("cart_id = " + @cart.id.to_s)
    
    # if @purchases.length > 0 then
      # for purchase in @purchases do
        # purchase.destroy
      # end
    # end

    # redirect_to carts_path
  end

# hide a cart (mark as hidden)
  def hide
    if !check_permission then return end
    @cart = Cart.find(params[:id])
    
    # method from a model
    @cart.hide(session[:login_id])

    redirect_to carts_path
  end    
  
  def unhide
    if !check_permission then return end
    @cart = Cart.find(params[:id])
    
    # method from a model
    @cart.unhide(session[:login_id])

    redirect_to carts_path
  end  


  private    
  def cart_params
    # params.require(:cart).permit(:name, :creation_date, "dupa",   :user_id => [session[:login_id].to_s]) 
    # params = ActionController::Parameters.new({
      # cart: {
        # name: @cart.name,
        # creation_date:  @cart.creation_date,
        # user_id: session[:login_id]
      # }
    # })
   # params.require(:cart).permit(:name, :created, :user_id)
  params[:cart][:user_id] = session[:login_id]
  params.require(:cart).permit(:name, :creation_date, :user_id)
  end
end
