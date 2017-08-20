class CategoriesController < ApplicationController
  
  def index
      @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
      @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)


    if @category.save
      @subcategory = Subcategory.new(subcategory_params)
      @subcategory.save
      raise Exception.new('something bad happened!')

      #redirect_to @category
    else
        raise Exception.new('something bad happened!')
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end


  private
  def category_params
    params.require(:category).permit(:category, :name)
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
