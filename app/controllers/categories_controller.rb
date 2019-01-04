class CategoriesController < ApplicationController
  def index  
    check_permission
    # get categories for logged user
    @categories = Category.where("user_id =" + cookies.signed[:login_id].to_s)
  end

  def show
    check_permission
    @category = Category.find(params[:id])
    @category.current_user_id = cookies.signed[:login_id]
    
    unless @category
        redirect_to  subcategories_path, notice: 'error, category does not exist'
    end
    
    # workaround for no auto-validation on this action
    if !@category.valid?
        redirect_to  categories_path, notice: @category.errors.full_messages.join(', ')
    end       
  end

  def new
    check_permission
    @category = Category.new
  end

  def edit
    check_permission
    @category = Category.find(params[:id])
    @category.current_user_id = cookies.signed[:login_id]
    
    unless @category
        redirect_to  subcategories_path, notice: 'error, category does not exist'
    end
    
    # workaround for no auto-validation on this action
    if !@category.valid?
        redirect_to  categories_path, notice: @category.errors.full_messages.join(', ')
    end
  end

  def create
    check_permission
    @category = Category.new(category_params)
    @category.current_user_id = cookies.signed[:login_id]

    if @category.save
      @subcategory = Subcategory.new(subcategory_params)
      @subcategory.current_user_id = cookies.signed[:login_id]
      @subcategory.save!
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    check_permission
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    check_permission
    @category = Category.find(params[:id])
    @subcategories = Subcategory.where("category_id = " + @category.id.to_s)
    
    for subcategory in @subcategories do
      subcategory.destroy
    end
    
    @category.destroy

    redirect_to categories_path
  end

  def hide
    check_permission
    @category = Category.find(params[:id])
    @category.current_user_id = cookies.signed[:login_id]
    @subcategories = Subcategory.where("category_id = " + @category.id.to_s)
    for subcategory in @subcategories do
      subcategory.hide(@category.current_user_id)
    end
    @category.hidden = true
    @category.save!

    redirect_to categories_path
  end  
  
  def unhide
    check_permission
    @category = Category.find(params[:id])
    @category.current_user_id = cookies.signed[:login_id]
    @subcategories = Subcategory.where("category_id = " + @category.id.to_s)
    for subcategory in @subcategories do
      subcategory.unhide(@category.current_user_id)
    end
    @category.hidden = false
    @category.save!

    redirect_to categories_path
  end 
  
  
  private
  def category_params
    params[:category][:user_id] = cookies.signed[:login_id]
    params.require(:category).permit(:category, :name, :user_id)
  end

  def subcategory_params
    #params.require(:category).permit(:subcategory, :name, :category_id)
    params = ActionController::Parameters.new({
      subcategory: {
        name: @category.name,
        category_id:  @category.id,
      }
    })
    params = params.require(:subcategory).permit(:subcategory, :name, :category_id)
  end

end
