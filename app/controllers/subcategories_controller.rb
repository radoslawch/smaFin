class SubcategoriesController < ApplicationController

  def index
    if !check_permission then return end
    @subcategories = Subcategory.left_joins(:category).where("user_id =" + session[:login_id].to_s)
  end

  def show
    if !check_permission then return end
    @subcategory = Subcategory.left_joins(:category).find(params[:id])
    @subcategory.current_user_id = session[:login_id]
    
    unless @subcategory
        redirect_to  subcategories_path, notice: 'error, subcategory does not exist'
    end
    
    # workaround for no auto-validation on this action
    if !@subcategory.valid?
        redirect_to subcategories_path, notice: @subcategory.errors.full_messages.join(', ')
    end
        
  end

  def new
    if !check_permission then return end
    @subcategory = Subcategory.new
    @categories = Category.where("user_id =" + session[:login_id].to_s)
    if @categories.length == 0 then
        redirect_to subcategories_path, notice: "Add a category first!"
    end
  end

  def edit
    if !check_permission then return end
    # left join category to show current category name
    @subcategory = Subcategory.left_joins(:category).find(params[:id])
    @subcategory.current_user_id = session[:login_id]
    
    @categories = Category.where("user_id =" + session[:login_id].to_s)
    
    if !@subcategory
        redirect_to subcategories_path, notice: 'subcategory not found'
    end  
    
    # workaround for no auto-validation on this action
    if !@subcategory.valid?
        redirect_to subcategories_path, notice: @subcategory.errors.full_messages.join(', ')
    end
    
  end

  # add auto-creation of a product? nah
  def create
    if !check_permission then return end
    @subcategory = Subcategory.new(subcategory_params)
    @subcategory.current_user_id = session[:login_id]
    
    # @categories = Category.where("user_id =" + session[:login_id].to_s)
    
    if @subcategory.save
      redirect_to @subcategory
    else
      render 'new'
    end
  end

  def update
    if !check_permission then return end
    @subcategory = Subcategory.find(params[:id])
    @subcategory.current_user_id = session[:login_id]
    
    # @categories = Category.where("user_id =" + session[:login_id].to_s)
    
    if @subcategory.update(subcategory_params)
      redirect_to @subcategory
    else
      render 'edit'
    end
  end

  def destroy
    if !check_permission then return end
    @subcategory = Subcategory.find(params[:id])
    @products = Product.where("subcategory_id = " + @subcategory.id.to_s)
    
    if products.length > 0 then
      for product in @products do
        product.destroy
      end
    end
    @subcategory.destroy

    redirect_to subcategories_path
  end
  
  def hide
    if !check_permission then return end
    @subcategory = Subcategory.find(params[:id])
    
    # method from a model
    @subcategory.hide(session[:login_id])

    redirect_to subcategories_path
  end  
  
  def unhide
    if !check_permission then return end
    @subcategory = Subcategory.find(params[:id])
    
    # method from a model
    @subcategory.unhide(session[:login_id])

    redirect_to subcategories_path
  end


  private
  def subcategory_params
    params.require(:subcategory).permit(:subcategory, :name, :category_id)
  end
end
