class SubcategoriesController < ApplicationController
  def index
      #@subcategories = Subcategory.all
      #@subcategories = Subcategory.find(:all, :include => :category)
      @subcategories = Subcategory.left_joins(:category)

  end

  def show
    @subcategory = Subcategory.find(params[:id])
  end

  def new
      @subcategory = Subcategory.new
      @categories =  Category.all
  end

  def edit
    @subcategory = Subcategory.find(params[:id])
    @categories =  Category.all
  end

  def create
    @subcategory = Subcategory.new(subcategory_params)

    if @subcategory.save
      redirect_to @subcategory
    else
      render 'new'
    end
  end

  def update
    @subcategory = Subcategory.find(params[:id])

    if @subcategory.update(subcategory_params)
      redirect_to @subcategory
    else
      render 'edit'
    end
  end

  def destroy
    @subcategory = Subcategory.find(params[:id])
    @subcategory.destroy

    redirect_to subcategories_path
  end


  private
  def subcategory_params
    params.require(:subcategory).permit(:subcategory, :name, :category_id)
  end
end
