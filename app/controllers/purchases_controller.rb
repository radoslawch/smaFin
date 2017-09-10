class PurchasesController < ApplicationController
  def index #lista wydatków
      @purchases = Purchase.left_joins(:cart).left_joins(:product)
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def new #nowy wydatek - widok
      @purchase = Purchase.new
      @carts =  Cart.all
      @products =  Product.all
      #@tag = Tag.new

      @categories =  Category.all
      @subcategories =  Subcategory.all
  end

  def edit
    @purchase = Purchase.find(params[:id])
    @carts =  Cart.all
    @products =  Product.all
    #@tag = @purchase.tag.build
    #render plain: params[:purchase].inspect

    @categories =  Category.all
    @subcategories =  Subcategory.all
  end

  def create #nowy wydatek - akcja
    @purchase = Purchase.new(purchase_params)
    @carts =  Cart.all
    @products =  Product.all

    if @purchase.save
      redirect_to @purchase
    else
      render 'new'
    end
  end

  def update
    @purchase = Purchase.find(params[:id])
    @carts =  Cart.all
    @products =  Product.all

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


  private
  def purchase_params
    params.require(:purchase).permit(:cart_id, :product_id, :amount, :price, :name)
  end
end
