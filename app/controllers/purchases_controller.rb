class PurchasesController < ApplicationController
  
  def index #lista wydatków
    check_permission
    @purchases = Purchase.left_joins(:cart).where("user_id =" + cookies.signed[:login_id].to_s)
  end

  def show
    check_permission
    @purchase = Purchase.find(params[:id])
    @purchase.current_user_id = cookies.signed[:login_id]
    
    unless @purchase
        redirect_to  purchases_path, notice: 'error, purchase does not exist'
    end
    
    # workaround for no auto-validation on this action
    if !@purchase.valid?
        redirect_to purchases_path, notice: @purchase.errors.full_messages.join(', ')
    end  
  end

  def new #nowy wydatek - widok
    check_permission
    @purchase = Purchase.new
    @carts =  Cart.where("user_id =" + cookies.signed[:login_id].to_s)
    @products = Product.left_joins(:subcategory => :category).where("user_id =" + cookies.signed[:login_id].to_s)
        
    @subcategories = Subcategory.left_joins(:category).where("user_id =" + cookies.signed[:login_id].to_s)
    @categories = Category.where("user_id =" + cookies.signed[:login_id].to_s)
    
    if @carts.length == 0 then
        redirect_to purchases_path, notice: "Add a cart first!"
    elsif @categories.length == 0 then
        redirect_to purchases_path, notice: "Add a category first!"
    elsif @subcategories.length == 0 then
        redirect_to purchases_path, notice: "Add a subcategory first!"
    elsif @products.length == 0 then
        redirect_to purchases_path, notice: "Add a product first!"
    end
  end

  def edit
    check_permission
    @purchase = Purchase.find(params[:id])
    @purchase.current_user_id = cookies.signed[:login_id]
    
    @carts =  Cart.where("user_id =" + cookies.signed[:login_id].to_s)
    @products = Product.left_joins(:subcategory => :category).where("user_id =" + cookies.signed[:login_id].to_s)
        
    @subcategories = Subcategory.left_joins(:category).where("user_id =" + cookies.signed[:login_id].to_s)
    @categories = Category.where("user_id =" + cookies.signed[:login_id].to_s)
    
    unless @purchase
        redirect_to  purchases_path, notice: 'error, purchase does not exist'
    end
    
    # workaround for no auto-validation on this action
    if !@purchase.valid?
        redirect_to  purchases_path, notice: @purchase.errors.full_messages.join(', ')
    end 
  end

  def create #nowy wydatek - akcja
    @purchase = Purchase.new(purchase_params)
    @purchase.current_user_id = cookies.signed[:login_id]
    
    @carts =  Cart.where("user_id =" + cookies.signed[:login_id].to_s)
    @products = Product.left_joins(:subcategory => :category).where("user_id =" + cookies.signed[:login_id].to_s)
        
    @subcategories = Subcategory.left_joins(:category).where("user_id =" + cookies.signed[:login_id].to_s)
    @categories = Category.where("user_id =" + cookies.signed[:login_id].to_s)
  
    if @purchase.save
      redirect_to @purchase
    else
      render 'new'
    end
  end

  def update
    @purchase = Purchase.find(params[:id])
    @purchase.current_user_id = cookies.signed[:login_id]
    
    @carts =  Cart.where("user_id =" + cookies.signed[:login_id].to_s)
    @products = Product.left_joins(:subcategory => :category).where("user_id =" + cookies.signed[:login_id].to_s)
        
    @subcategories = Subcategory.left_joins(:category).where("user_id =" + cookies.signed[:login_id].to_s)
    @categories = Category.where("user_id =" + cookies.signed[:login_id].to_s)
    if @purchase.update(purchase_params)
      #update sucessfull
      #redirect to cart the purchase belongs to
      redirect_to @purchase.cart
    else
      render 'edit'
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    redirect_to spendings_path
  end
  
  def hide
    check_permission
    @purchase = Purchase.find(params[:id])
    
    # method from a model
    @purchase.hide(cookies.signed[:login_id])

    # redirect_to subcategories_path
    redirect_to @purchase.cart
  end  
  
  def unhide
    check_permission
    @purchase = Purchase.find(params[:id])
    
    # method from a model
    @purchase.unhide(cookies.signed[:login_id])

    # redirect_to subcategories_path
    redirect_to @purchase.cart
  end


  private
  def purchase_params
    params.require(:purchase).permit(:cart_id, :product_id, :amount, :price, :name)
  end
end
