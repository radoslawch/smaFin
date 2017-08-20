class CartsController < ApplicationController
  

  def index #lista koszykow
    @carts = Cart.all
  end

  def show
    #to show chosen cart
    @cart = Cart.find(params[:id]) 
    #which contains some purchases
    @purchases = Purchase.left_joins(:cart).where("cart_id =" + params[:id])
    
    #to add next purchase easly
    @purchase = Purchase.new
    #to chose a product to add
    @products =  Product.left_joins(:subcategory)
    #which has some category and subcategory
    @subcategories =  Subcategory.left_joins(:category)
    @categories =  Category.all
  end

  def new #nowy koszyk - widok
      @cart = Cart.new
  end

  def edit
    @cart = Cart.find(params[:id])
    #render plain: params[:spending].inspect
  end

  def create #nowy wydatek - akcja
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart
    else
      render 'new'
    end
  end

  def update
    @cart = Cart.find(params[:id])

    if @cart.update(cart_params)
      redirect_to @cart
    else
      render 'edit'
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    redirect_to carts_path
  end

  def hide
    logger.info "Processing the request..."
    @cart = Cart.find(params[:id])
    logger.info 'cart'
    logger.info @cart
    logger.info '@cart.hidden ='
    logger.info @cart.hidden
    logger.info '!@cart.hidden ='
    logger.info @cart.hidden
    @cart.hidden = !@cart.hidden
    @cart.save!

    redirect_to carts_path
  end


  private
  def cart_params
    params.require(:cart).permit(:name, :created)
  end
end
