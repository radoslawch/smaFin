class PurchasesController < ApplicationController
  
  def index #lista wydatków
    if !check_permission then return end
    @purchases = Purchase.left_joins(:cart).where("user_id =" + cookies.signed[:login_id].to_s)
  end

  def show
    if !check_permission then return end
    # workaround for no auto-validation on this action
    if !@purchase.valid?
        redirect_to purchases_path, notice: @purchase.errors.full_messages.join(', ')
    end
    
    @purchase = Purchase.find(params[:id])
    @purchase.current_user_id = cookies.signed[:login_id]
    
    unless @purchase
        redirect_to  purchases_path, notice: 'error, purchase does not exist'
    end
    
  
  end

  def new #nowy wydatek - widok
    if !check_permission then return end
    @purchase = Purchase.new
    @carts =  Cart.where("user_id =" + cookies.signed[:login_id].to_s)
    @products = Product.left_joins(:subcategory => :category).where("user_id =" + cookies.signed[:login_id].to_s)
        
    @subcategories = Subcategory.left_joins(:category).where("user_id =" + cookies.signed[:login_id].to_s)
    @categories = Category.where("user_id =" + cookies.signed[:login_id].to_s)
    
    notice_string = ""
    if @carts.length == 0 then
      notice_string += "Add a cart first! "
    end
    if @categories.length == 0 then
      notice_string += "Add a category first! "
    end
    if @subcategories.length == 0 then
      notice_string += "Add a subcategory first! "
    end
    if @products.length == 0 then
      notice_string += "Add a product first! "
    end
    if notice_string != "" then
      redirect_to purchases_path, notice: notice_string
    end
  end

  def edit
    if !check_permission then return end
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
    if !check_permission then return end
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
    if !check_permission then return end
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
    if !check_permission then return end
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    redirect_to spendings_path
  end
  
  def hide
    if !check_permission then return end
    @purchase = Purchase.find(params[:id])
    
    # method from a model
    @purchase.hide(cookies.signed[:login_id])

    # redirect_to subcategories_path
    redirect_to @purchase.cart
  end  
  
  def unhide
    if !check_permission then return end
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
