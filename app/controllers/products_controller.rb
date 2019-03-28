class ProductsController < ApplicationController
  
  def index #lista produktow
    if !check_permission then return end
    @products = Product.left_joins(:subcategory => :category).where("user_id =" + session[:login_id].to_s)
  end

  def show
    if !check_permission then return end
    @product = Product.find(params[:id])
    @product.current_user_id = session[:login_id]
    
    unless @product
        redirect_to  products_path, notice: 'error, product does not exist'
    end
    
    # workaround for no auto-validation on this action
    if !@product.valid?
        redirect_to  products_path, notice: @product.errors.full_messages.join(', ')
    end
    
  end

  def new #nowy wydatek - widok
    if !check_permission then return end
    @product = Product.new
    @categories =  Category.where("user_id =" + session[:login_id].to_s)
    @subcategories =  Subcategory.left_joins(:category).where("user_id =" + session[:login_id].to_s)
    if @categories.length == 0 then
        redirect_to products_path, notice: "Add a category first!"
    elsif @subcategories.length == 0 then
        redirect_to products_path, notice: "Add a subcategory first!"
    end
  end

  def edit
    if !check_permission then return end
    # left join subcategory to show current subcategory name
    @product = Product.left_joins(:subcategory).find(params[:id])
    @product.current_user_id = session[:login_id]
    
    @categories =  Category.where("user_id =" + session[:login_id].to_s)
    # is left join needed?
    @subcategories =  Subcategory.left_joins(:category).where("user_id =" + session[:login_id].to_s)
    
    if !@product
        redirect_to  subcategories_path, notice: 'product not found'
    end  
    
    # workaround for no auto-validation on this action
    if !@product.valid?
        redirect_to  subcategories_path, notice: @product.errors.full_messages.join(', ')
    end
    
  end

  def create #nowy wydatek - akcja
    if !check_permission then return end
    @product = Product.new(product_params)
    @product.current_user_id = session[:login_id]
    
    # @categories =  Category.where("user_id =" + session[:login_id].to_s)
    # @subcategories =  Subcategory.left_joins(:category).where("user_id =" + session[:login_id].to_s)

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    if !check_permission then return end
    @product = Product.find(params[:id])
    @product.current_user_id = session[:login_id]
    
    # @categories =  Category.where("user_id =" + session[:login_id].to_s)
    # @subcategories =  Subcategory.left_joins(:category).where("user_id =" + session[:login_id].to_s)

    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    if !check_permission then return end
    @product = Product.find(params[:id])
    
    @purchases = Purchase.where("product_id = " + @product.id.to_s)
    
    if @purchases.length > 0 then
      for purchase in @purchases do
        purchase.destroy
      end
    end
    @product.destroy

    redirect_to products_path
  end

  def hide
    if !check_permission then return end
    @product = Product.find(params[:id])

    # method from a model
    @product.hide(session[:login_id])

    redirect_to products_path
  end  
  
  def unhide
    if !check_permission then return end
    @product = Product.find(params[:id])

    # method from a model
    @product.unhide(session[:login_id])

    redirect_to products_path
  end 

  private
  def product_params
    params.require(:product).permit(:subcategory_id, :name, :unit)
  end
end
