class ProductsController < ApplicationController
  def index #lista produktow
      @products = Product.left_joins(:subcategory => :category)#.left_joins(:category)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new #nowy wydatek - widok
      @product = Product.new
      @categories =  Category.all
      @subcategories =  Subcategory.all
      #@tag = Tag.new
  end

  def edit
    @product = Product.find(params[:id])
    @categories =  Category.all
    @subcategories =  Subcategory.left_joins(:category)
    #@tag = @spending.tag.build
    #render plain: params[:spending].inspect
  end

  def create #nowy wydatek - akcja
    @product = Product.new(product_params)
    @categories =  Category.all
    @subcategories =  Subcategory.all

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    @categories =  Category.all
    @subcategories =  Subcategory.left_joins(:category)

    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to spendings_path
  end


  private
  def product_params
    params.require(:product).permit(:subcategory_id, :name, :unit)
  end
end
